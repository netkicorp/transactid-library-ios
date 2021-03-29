//
//  OpenSSLSigningHelper.h
//  transactId-library-ios
//
//  Created by Developer on 15.03.2021.
//

#ifndef OpenSSLSigningHelper_h
#define OpenSSLSigningHelper_h

#include <stdio.h>
#include <string>
#include <vector>
#include "OpenSSLCommonHelper.h"

namespace transact_id_ssl {

struct SignData : public Operation
{
    SignData();
    
    bool base64;
    bool newLine;
    
    std::string passphrase;
    std::string privateKey;
    std::string message;
    
    std::string signature;
    std::string publicKey;
    std::string errorInfo;
};

bool signMessage(SignData& data);

std::string hash256(unsigned char * data, size_t dataSize);

std::vector<std::string> certificatePemToChains(const char* cert_pem);

bool isSigned(const char* cert_pem);

bool isRootCertificate(const char* cert_pem);

bool isIntermediateCertificate(const char* cert_pem);

bool isClientCertificate(const char* cert_pem);

bool validateCertificateNotBeforeExpiration(const char* cert_pem);

bool validateCertificateNotAfterExpiration(const char* cert_pem);

std::vector<std::string> getCRLDistributionPoints(const char* cert_pem);

bool isEvCertificate(const char* cert_pem);

bool validateSignatureECDSA(unsigned char * original, size_t originalSize, std::string publicKey, std::string data);

bool validateSignature(unsigned char * original, size_t originalSize, const char* certificate, std::string data);


}

#endif /* OpenSSLSigningHelper_hpp */
