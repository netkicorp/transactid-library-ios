//
//  OpenSSLCSRHelper.h
//  transactId-library-ios
//
//  Created by Developer on 02.02.2021.
//

#ifndef OpenSSLCSRHelper_h
#define OpenSSLCSRHelper_h

#include <string>
#include "OpenSSLCommonHelper.h"

namespace transact_id_ssl {

enum KeyType
{
    Rsa,
    Ecdsa
};

//struct Operation
//{
//    std::string errorInfo;
//};

struct CsrData : public Operation
{
    CsrData();
    
    KeyType type;
    
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

} //namespace transact_id_ssl


#endif /* SSLHelper_h */
