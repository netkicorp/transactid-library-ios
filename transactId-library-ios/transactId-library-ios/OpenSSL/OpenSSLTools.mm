//
//  OpenSSLTools.m
//  transactId-library-ios
//
//  Created by Developer on 02.02.2021.
//

#import "OpenSSLTools.h"
#include <OpenSSL/OpenSSL.h>
#include "OpenSSLCSRHelper.h"
#include "OpenSSLSigningHelper.h"
#include "OpenSSLEncryptionHelper.h"

@implementation OpenSSLKeyGenerateResult
    
- (instancetype)initWithPublicKey:(NSString *)publicKey
                       privateKey:(NSString *)privateKey
                              csr:(NSString *)csr
{
    if (self = [super init]) {
        self.publicKeyBase64 = publicKey;
        self.privateKeyBase64 = privateKey;
        self.csrBase64 = csr;
    }
    return self;
}
    
@end

@implementation OpenSSLKeyGenerationParams

- (instancetype)initWithCn:(NSString *)cn
                       org:(NSString *)org
                   country:(NSString *)country
                     state:(NSString *)state
                      city:(NSString *)city
                passphrase:(NSString *)passphrase
{
    if (self = [super init]) {
        self.CN = cn;
        self.O = org;
        self.C = country;
        self.ST = state;
        self.L = city;
        self.passphrase = passphrase;
    }
    return self;
}

@end

@implementation OpenSSLTools

- (instancetype)init {
    if (self = [super init]) {
        OpenSSL_add_all_algorithms();
    }
    return self;
}

- (OpenSSLKeyGenerateResult *)generateCertificate:(OpenSSLKeyGenerationParams *)generationParameters {

    transact_id_ssl::CsrData csrData;
    
    csrData.country = std::string(generationParameters.C.UTF8String);
    csrData.state = std::string(generationParameters.ST.UTF8String);
    csrData.city = std::string(generationParameters.L.UTF8String);
    csrData.org = std::string(generationParameters.O.UTF8String);
    csrData.cn = std::string(generationParameters.CN.UTF8String);
    csrData.passphrase = std::string(generationParameters.passphrase.UTF8String);
    
    transact_id_ssl::generateCsr(csrData);
    
    NSString *publicKey = [NSString stringWithUTF8String:csrData.publicKey.c_str()];
    NSString *privateKey = [NSString stringWithUTF8String:csrData.privateKey.c_str()];
    NSString *csr = [NSString stringWithUTF8String:csrData.request.c_str()];
    
    return [[OpenSSLKeyGenerateResult alloc] initWithPublicKey:publicKey
                                                    privateKey:privateKey
                                                           csr:csr];
}

- (NSArray *)pemToCertificatesArray:(NSString *)certificate {
            
    std::vector<std::string> chains = transact_id_ssl::certificatePemToChains(std::string(certificate.UTF8String).c_str());
    
    NSMutableArray *certificates = [NSMutableArray new];
    
    for(int i = 0; i < chains.size(); i++){
        NSString * chain = [NSString stringWithUTF8String: chains[i].c_str()];
        [certificates addObject:chain];
    }
    
    return [certificates copy];
    
}

- (BOOL)isSigned:(NSString *)certificate {
    return transact_id_ssl::isSigned(std::string(certificate.UTF8String).c_str());
}

- (BOOL)isRootCertificate:(NSString *)certificate {
    return transact_id_ssl::isRootCertificate(std::string(certificate.UTF8String).c_str());
}

- (BOOL)isIntermediateCertificate:(NSString *)certificate {
    return transact_id_ssl::isIntermediateCertificate(std::string(certificate.UTF8String).c_str());
}

- (BOOL)isClientCertificate:(NSString *)certificate {
    return transact_id_ssl::isClientCertificate(std::string(certificate.UTF8String).c_str());
}

- (BOOL)validateNotBeforeExpirationCertificate:(NSString *)certificate {
    return transact_id_ssl::validateCertificateNotBeforeExpiration(std::string(certificate.UTF8String).c_str());
}

- (BOOL)validateNotAfterExpirationCertificate:(NSString *)certificate {
    return transact_id_ssl::validateCertificateNotAfterExpiration(std::string(certificate.UTF8String).c_str());
}

- (NSArray *)getCRLDistributionPoints:(NSString *)certificate {
    
    std::vector<std::string> points = transact_id_ssl::getCRLDistributionPoints(std::string(certificate.UTF8String).c_str());
    
    NSMutableArray *crlPoints = [NSMutableArray new];
    
    for(int i = 0; i < points.size(); i++){
        NSString * point = [NSString stringWithUTF8String: points[i].c_str()];
        [crlPoints addObject:point];
    }
    
    return [crlPoints copy];
}

- (BOOL)isRevoked:(NSString*)crl certificate:(NSString *)certificate {
    return NO;
}

- (NSData *)sign:(NSString*)privateKey message:(NSString*)message newLine:(BOOL)newLine {

    transact_id_ssl::SignData signData;
    
    signData.base64 = true;
    signData.message = std::string(message.UTF8String);
    signData.privateKey = std::string(privateKey.UTF8String);
    
    transact_id_ssl::signMessage(signData);
    
    NSString * signature = [NSString stringWithUTF8String:signData.signature.c_str()];
    
    return [signature dataUsingEncoding:NSUTF8StringEncoding];
    
}

- (NSString *)encrypt:(NSString *)message
    receiverPublicKey:(NSString *)receiverPublicKey
      senderPublicKey:(NSString *)senderPublicKey
     senderPrivateKey:(NSString *)senderPrivateKey {
    
    transact_id_ssl::EncryptionData encryptionData;

    encryptionData.message = std::string(message.UTF8String);
    encryptionData.publicKeyReceiver = std::string(receiverPublicKey.UTF8String);
    encryptionData.publicKeySender = std::string(senderPublicKey.UTF8String);
    encryptionData.privateKeySender = std::string(senderPrivateKey.UTF8String);
    
    transact_id_ssl::encrypt(encryptionData);
        
    return [NSString stringWithUTF8String:encryptionData.encryptedMessage.data()];
}

- (NSString *)decrypt:(NSString *)encryptedMessage
   receiverPrivateKey:(NSString *)receiverPrivateKey
      senderPublicKey:(NSString *)senderPublicKey {
    
    transact_id_ssl::EncryptionData encryptionData;
    
    encryptionData.encryptedMessage = std::string(encryptedMessage.UTF8String);
    encryptionData.privateKeyReceiver = std::string(receiverPrivateKey.UTF8String);
    encryptionData.publicKeySender = std::string(senderPublicKey.UTF8String);

    transact_id_ssl::decrypt(encryptionData);

    return [NSString stringWithUTF8String:encryptionData.message.data()];

}

- (NSString *)hash256:(NSData *)messageData {
    NSUInteger size = [messageData length] / sizeof(unsigned char);
    unsigned char* array = (unsigned char*) [messageData bytes];
    return [NSString stringWithUTF8String:transact_id_ssl::hash256(array, size).data()];
}

- (BOOL)validateSignatureECDSA:(NSString *)originalSignature publicKey:(NSString *)publicKey data:(NSString *)data {
    NSData *decodedSignatureData = [[NSData alloc] initWithBase64EncodedString:originalSignature options:0];
    NSUInteger signatureSize = [decodedSignatureData length] / sizeof(unsigned char);
    unsigned char* signature = (unsigned char*) [decodedSignatureData bytes];
        
    return transact_id_ssl::validateSignatureECDSA(signature, signatureSize, std::string(publicKey.UTF8String), std::string(data.UTF8String));
}

- (BOOL)validateSignature:(NSString *)originalSignature certificate:(NSString *)certificate data:(NSString *)data {
    NSData *decodedSignatureData = [[NSData alloc] initWithBase64EncodedString:originalSignature options:0];
    NSUInteger signatureSize = [decodedSignatureData length] / sizeof(unsigned char);
    unsigned char* signature = (unsigned char*) [decodedSignatureData bytes];
    
    return transact_id_ssl::validateSignature(signature, signatureSize, std::string(certificate.UTF8String).c_str(), std::string(data.UTF8String));
}




@end
