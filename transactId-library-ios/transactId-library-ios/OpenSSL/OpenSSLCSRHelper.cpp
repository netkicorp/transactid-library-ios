//
//  OpenSSLCSRHelper.cpp
//  transactId-library-ios
//
//  Created by Developer on 02.02.2021.
//

#include "OpenSSLCSRHelper.h"
#include <memory>
#include <openssl/err.h>
#include <openssl/pem.h>
#include <openssl/x509.h>
#include <openssl/x509v3.h>
#include <openssl/ssl.h>
#include <openssl/crypto.h>
#include <openssl/ocsp.h>
#include <iostream>

namespace transact_id_ssl {

CsrData::CsrData() : type(Rsa) { }

bool generateKey(CsrData& data, std::shared_ptr<EVP_PKEY> key)
{
    int ret = 0;
    
    switch (data.type)
    {
        case Rsa:
        {
            std::shared_ptr<BIGNUM> bn(BN_new(), &BN_free);
            ret = BN_set_word(bn.get(), RSA_F4);
            if (ret != 1) {
                reportError(data);
                return false;
                
            }
            
            bool own = true;
            std::shared_ptr<RSA> rsa(RSA_new(), [&own] (RSA* it) { if (own) RSA_free(it); });
            ret = RSA_generate_key_ex(rsa.get(), 2048, bn.get(), nullptr);
            if (ret != 1) {
                reportError(data);
                return false;
                
            }
            
            ret = EVP_PKEY_assign_RSA(key.get(), rsa.get());
            if (ret != 1) {
                reportError(data);
                return false;
            }
            own = false;
        }
            break;
            
        case Ecdsa:
        {
            bool own = true;
            std::shared_ptr<EC_KEY> ec(EC_KEY_new_by_curve_name(NID_secp256k1),
                                       [&own] (EC_KEY* it) { if (own) EC_KEY_free(it); });
            
            ret = EC_KEY_generate_key(ec.get());
            if (ret != 1) { reportError(data); return false; }
            
            ret = EVP_PKEY_assign_EC_KEY(key.get(), ec.get());
            if (ret != 1) { reportError(data); return false; }
            own = false;
        }
            break;
            
        default: data.errorInfo = "Invalid key type"; return false;
    }
    
    return true;
}

bool generateCsr(CsrData& data)
{
    int ret = 0;
    
    std::shared_ptr<X509_REQ> request(X509_REQ_new(), &X509_REQ_free);
    ret = X509_REQ_set_version(request.get(), 1);
    if (ret != 1) { reportError(data); return false; }
    
    X509_NAME* name = X509_REQ_get_subject_name(request.get());
    if (name == nullptr) { reportError(data); return false; }
    
    if (!data.country.empty())
    {
        ret = X509_NAME_add_entry_by_txt(name, "C", MBSTRING_UTF8,
                                         reinterpret_cast<const unsigned char*> (data.country.c_str()),
                                         -1, -1, 0);
        if (ret != 1) { reportError(data); return false; }
    }
    
    if (!data.state.empty())
    {
        ret = X509_NAME_add_entry_by_txt(name, "ST", MBSTRING_UTF8,
                                         reinterpret_cast<const unsigned char*> (data.state.c_str()),
                                         -1, -1, 0);
        if (ret != 1) { reportError(data); return false; }
    }
    
    if (!data.city.empty()) {
        ret = X509_NAME_add_entry_by_txt(name, "L", MBSTRING_UTF8,
                                         reinterpret_cast<const unsigned char*> (data.city.c_str()),
                                         -1, -1, 0);
        if (ret != 1) { reportError(data); return false; }
    }
    
    if (!data.org.empty())
    {
        ret = X509_NAME_add_entry_by_txt(name, "O", MBSTRING_UTF8,
                                         reinterpret_cast<const unsigned char*> (data.org.c_str()),
                                         -1, -1, 0);
        if (ret != 1) { reportError(data); return false; }
    }
    
    if (!data.cn.empty())
    {
        ret = X509_NAME_add_entry_by_txt(name, "CN", MBSTRING_UTF8,
                                         reinterpret_cast<const unsigned char*> (data.cn.c_str()),
                                         -1, -1, 0);
        if (ret != 1) { reportError(data); return false; }
    }
    
    std::shared_ptr<EVP_PKEY> key(EVP_PKEY_new(), &EVP_PKEY_free);
    if (!generateKey(data, key)) return false;
    
    ret = X509_REQ_set_pubkey(request.get(), key.get());
    if (ret != 1) { reportError(data); return false; }
    
    ret = X509_REQ_sign(request.get(), key.get(), EVP_sha256());
    if (ret <= 1) { reportError(data); return false; }
    
    BioString bio;
    ret = PEM_write_bio_X509_REQ(bio.get(), request.get());
    if (ret != 1) { reportError(data); return false; }
    data.request = bio.toString();
    
    RSA* rsa = EVP_PKEY_get1_RSA(key.get());
    
    ret = PEM_write_bio_RSAPrivateKey(bio.get(), rsa, nullptr, nullptr, 0, nullptr, const_cast<char*> (data.passphrase.c_str()));
    
    
    if (ret != 1) { reportError(data); return false; }
    data.privateKey = bio.toString();
    
    ret = PEM_write_bio_PUBKEY(bio.get(), key.get());
    if (ret != 1) { reportError(data); return false; }
    data.publicKey = bio.toString();
    
    return true;
}

} //namespace transact_id_ssl
