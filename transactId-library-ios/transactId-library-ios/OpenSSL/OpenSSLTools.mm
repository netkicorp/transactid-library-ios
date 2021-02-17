//
//  OpenSSLTools.m
//  transactId-library-ios
//
//  Created by Developer on 02.02.2021.
//

#import "OpenSSLTools.h"
#include <OpenSSL/OpenSSL.h>
#import "OpenSSLHelper.h"

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



@end
