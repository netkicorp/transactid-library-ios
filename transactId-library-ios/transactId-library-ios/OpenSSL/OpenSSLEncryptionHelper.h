//
//  OpenSSLEncryptionHelper.h
//  transactId-library-ios
//
//  Created by Developer on 15.03.2021.
//

#ifndef OpenSSLEncryptionHelper_h
#define OpenSSLEncryptionHelper_h

#include <stdio.h>
#include <string>
#include "OpenSSLCommonHelper.h"

namespace transact_id_ssl {

struct EncryptionData : public Operation
{
    EncryptionData();

    std::string encryptedMessage;
    std::string message;
    
    std::string publicKeyReceiver;
    std::string privateKeyReceiver;
    
    std::string publicKeySender;
    std::string privateKeySender;
};


bool encrypt(EncryptionData& data);

bool decrypt(EncryptionData& data);


}

#endif /* OpenSSLEncryptionHelper_hpp */


