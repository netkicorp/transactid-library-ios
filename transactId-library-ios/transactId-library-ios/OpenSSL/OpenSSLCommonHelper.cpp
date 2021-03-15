//
//  OpenSSLCommonHelper.cpp
//  transactId-library-ios
//
//  Created by Developer on 15.03.2021.
//

#include "OpenSSLCommonHelper.h"
#include <stdio.h>

namespace transact_id_ssl {


//class BioString
//{
//public:
//    BioString() : data(BIO_new(BIO_s_mem()), &BIO_free) { }
//    BioString(const std::string& value) : data(BIO_new(BIO_s_mem()), &BIO_free)
//    {
//        BIO_write(data.get(), value.c_str(), static_cast<int> (value.size()));
//    }
//    
//    BIO* get()
//    {
//        return data.get();
//        
//    }
//    
//    std::string toString()
//    {
//        std::string res;
//        res.resize(BIO_number_written(data.get()));
//        BIO_read(data.get(), const_cast<char*> (res.data()), static_cast<int> (res.size()));
//        reset();
//        return res;
//    }
//    
//    void reset()
//    {
//        data.reset(BIO_new(BIO_s_mem()), &BIO_free);
//    }
//    
//private:
//    std::shared_ptr<BIO> data;
//};

void reportError(Operation& op)
{
    BioString info;
    ERR_print_errors(info.get());
    op.errorInfo = info.toString();
}

}
