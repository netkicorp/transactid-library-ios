//
//  OpenSSLHelper.h
//  transactId-library-ios
//
//  Created by Developer on 02.02.2021.
//

#ifndef OpenSSLHelper_h
#define OpenSSLHelper_h

#include <string>
#include <vector>

namespace transact_id_ssl {

enum KeyType
{
    Rsa,
    Ecdsa
};

struct Operation
{
    std::string errorInfo;
};

struct CsrData : public Operation
{
    CsrData();
    
    KeyType     type;
    
    std::string country;
    std::string state;
    std::string city;
    std::string org;
    std::string cn;
    std::string passphrase;
    
    std::string request;
    std::string publicKey;
    std::string privateKey;

};

bool generateCsr(CsrData& data);

struct SignData : public Operation
{
    SignData();
    
    bool base64;
    
    std::string passphrase;
    std::string privateKey;
    std::string message;
    
    std::string signature;
    std::string publicKey;
    std::string errorInfo;
};

struct EncryptionData : public Operation
{
    EncryptionData();
    
    bool base64;

    std::string encryptedMessage;
    std::string message;
    std::string publicKeyReceiver;
    std::string publicKeySender;
    std::string privateKeySender;
    
    ~EncryptionData();
};


bool signMessage(SignData& data);

std::vector<std::string> certificatePemToChains(const char* cert_pem);

bool isSigned(const char* cert_pem);

bool isRootCertificate(const char* cert_pem);

bool isIntermediateCertificate(const char* cert_pem);

bool isClientCertificate(const char* cert_pem);

bool validateCertificateNotBeforeExpiration(const char* cert_pem);

bool validateCertificateNotAfterExpiration(const char* cert_pem);

std::vector<std::string> getCRLDistributionPoints(const char* cert_pem);

bool generateHash256(SignData& data);

bool encrypt(EncryptionData& data);

} //namespace transact_id_ssl


#endif /* SSLHelper_h */
