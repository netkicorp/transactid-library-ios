//
//  OpenSSLTools.h
//  transactId-library-ios
//
//  Created by Developer on 02.02.2021.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OpenSSLKeyGenerateResult: NSObject

@property (nonatomic, strong) NSString *publicKeyBase64;
@property (nonatomic, strong) NSString *privateKeyBase64;
@property (nonatomic, strong) NSString *csrBase64;

@end

@interface OpenSSLKeyGenerationParams: NSObject

@property (nonatomic, strong) NSString *CN;
@property (nonatomic, strong) NSString *O;
@property (nonatomic, strong) NSString *C;
@property (nonatomic, strong) NSString *ST;
@property (nonatomic, strong) NSString *L;
@property (nonatomic, strong) NSString *passphrase;


- (instancetype)initWithCn:(NSString *)cn
                       org:(NSString *)org
                   country:(NSString *)country
                     state:(NSString *)state
                      city:(NSString *)city
                passphrase: (NSString *)passphrase;
@end

@interface OpenSSLTools : NSObject

- (OpenSSLKeyGenerateResult *)generateCertificate:(OpenSSLKeyGenerationParams *)generationParameters;

- (NSArray *)pemToCertificatesArray:(NSString *)certificate;

- (BOOL)isSigned:(NSString *)certificate;

- (BOOL)isRootCertificate:(NSString *)certificate;

- (BOOL)isIntermediateCertificate:(NSString *)certificate;

- (BOOL)isClientCertificate:(NSString *)certificate;

- (BOOL)validateNotBeforeExpirationCertificate:(NSString *)certificate;

- (BOOL)validateNotAfterExpirationCertificate:(NSString *)certificate;

- (NSArray *)getCRLDistributionPoints:(NSString *)certificate;

- (BOOL)isRevoked:(NSString*)crl certificate:(NSString *)certificate;

- (NSData *)sign:(NSString*)privateKey message:(NSString*)message newLine:(BOOL)newLine;

- (NSString *)encrypt:(NSString *)message
    receiverPublicKey:(NSString *)receiverPublicKey
      senderPublicKey:(NSString *)senderPublicKey
     senderPrivateKey:(NSString *)senderPrivateKey;

- (NSString *)decrypt:(NSString *)encryptedMessage
   receiverPrivateKey:(NSString *)receiverPrivateKey
      senderPublicKey:(NSString *)senderPublicKey;

- (NSString *)hash256:(NSData *)messageData;

- (BOOL)validateSignatureECDSA:(NSString *)originalSignature publicKey:(NSString *)publicKey data:(NSString *)data;

- (BOOL)validateSignature:(NSString *)originalSignature certificate:(NSString *)certificate data:(NSString *)data;

@end

NS_ASSUME_NONNULL_END
