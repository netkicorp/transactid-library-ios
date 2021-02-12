//
//  OpenSSLHelper.cpp
//  transactId-library-ios
//
//  Created by Developer on 02.02.2021.
//

#include "OpenSSLHelper.h"
#include <memory>
#include <openssl/err.h>
#include <openssl/pem.h>
#include <openssl/x509.h>

namespace transact_id_ssl {

CsrData::CsrData() : type(Rsa) { }

SignData::SignData(): base64(false) { }

class BioString
{
public:
    BioString() : data(BIO_new(BIO_s_mem()), &BIO_free) {}
    BioString(const std::string& value) : data(BIO_new(BIO_s_mem()), &BIO_free)
    { BIO_write(data.get(), value.c_str(), static_cast<int> (value.size())); }
    
    BIO* get() { return data.get(); }
    
    std::string toString()
    {
        std::string res;
        res.resize(BIO_number_written(data.get()));
        BIO_read(data.get(), const_cast<char*> (res.data()), static_cast<int> (res.size()));
        reset();
        return res;
    }
    
    void reset()
    {
        data.reset(BIO_new(BIO_s_mem()), &BIO_free);
    }
    
private:
    std::shared_ptr<BIO> data;
};

void reportError(Operation& op)
{
    BioString info;
    ERR_print_errors(info.get());
    op.errorInfo = info.toString();
}

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

bool signRsa(std::shared_ptr<EVP_PKEY> key, SignData& data, std::string& res)
{
    int ret = 0;
    
    std::shared_ptr<EVP_MD_CTX> md(EVP_MD_CTX_create(), &EVP_MD_CTX_destroy);
    EVP_PKEY_CTX* kctx = nullptr;
    ret = EVP_DigestSignInit(md.get(), &kctx, EVP_sha256(), nullptr, key.get());
    if (ret != 1) { reportError(data); return false; }
    
    if (EVP_PKEY_base_id(key.get()) == EVP_PKEY_RSA)
    {
        ret = EVP_PKEY_CTX_set_rsa_padding(kctx, RSA_PKCS1_PADDING);
        if (ret != 1) { reportError(data); return false; }
    }
    
    ret = EVP_DigestSignUpdate(md.get(), data.message.c_str(), data.message.size());
    if (ret != 1) { reportError(data); return false; }
    
    size_t sz = 0;
    ret = EVP_DigestSignFinal(md.get(), nullptr, &sz);
    if (ret != 1) { reportError(data); return false; }
    
    res.resize(sz);
    ret = EVP_DigestSignFinal(md.get(), reinterpret_cast<unsigned char*> (const_cast<char*> (res.data())), &sz);
    if (ret != 1) { reportError(data); return false; }
    
    return true;
}

bool signEc(std::shared_ptr<EVP_PKEY> key, SignData& data, std::string& res)
{
    int ret = 0;
    
    SHA256_CTX context;
    ret = SHA256_Init(&context);
    if (ret != 1) { reportError(data); return false; }
    
    ret = SHA256_Update(&context, data.message.c_str(), data.message.size());
    if (ret != 1) { reportError(data); return false; }
    
    unsigned char hash[SHA256_DIGEST_LENGTH];
    ret = SHA256_Final(hash, &context);
    if (ret != 1) { reportError(data); return false; }
    
    EC_KEY* eck = EVP_PKEY_get1_EC_KEY(key.get());
    if (eck == nullptr) { reportError(data); return false; }
    
    unsigned int sz = static_cast<unsigned int> (ECDSA_size(eck));
    if (sz == 0) { reportError(data); return false; }
    res.resize(static_cast<size_t> (sz));
    
    ret = ECDSA_sign(0, hash, SHA256_DIGEST_LENGTH, reinterpret_cast<unsigned char*> (const_cast<char*> (res.data())),
                     &sz, eck);
    if (ret != 1) { reportError(data); return false; }
    
    return true;
}

bool signMessage(SignData& data)
{
    int ret = 0;
    
    BioString bio(data.privateKey);
    EVP_PKEY* pk = PEM_read_bio_PrivateKey(bio.get(), nullptr, nullptr, const_cast<char*> (data.passphrase.c_str()));
    if (pk == nullptr) { reportError(data); return false; }
    
    std::shared_ptr<EVP_PKEY> key(pk, &EVP_PKEY_free);
    
    bio.reset();
    ret = PEM_write_bio_PUBKEY(bio.get(), key.get());
    if (ret != 1) { reportError(data); return false; }
    data.publicKey = bio.toString();
    
    std::string sig;
    
    switch (EVP_PKEY_base_id(key.get()))
    {
        case EVP_PKEY_RSA: if (!signRsa(key, data, sig)) return false; break;
        case EVP_PKEY_EC: if (!signEc(key, data, sig)) return false; break;
        default: data.errorInfo = "Invalid public key format"; return false;
    }
    
    if (data.base64)
    {
        std::shared_ptr<BIO> b64(BIO_new(BIO_f_base64()), &BIO_free);
        //BIO_set_flags(b64.get(), BIO_FLAGS_BASE64_NO_NL);
        BIO_push(b64.get(), bio.get());
        BIO_write(b64.get(), sig.data(), static_cast<int> (sig.size()));
        BIO_flush(b64.get());
        BIO_pop(b64.get());
        data.signature = bio.toString();
    } else
        data.signature = sig;
    
    return true;
}


std::vector<std::string> certificatePemToChains(const char* cert_pem) {
    std::vector<std::string> chains;
    
    STACK_OF(X509_INFO) *x509_info = PEM_X509_INFO_read_bio(BIO_new_mem_buf((void*)cert_pem, -1), NULL, NULL, NULL);
    
    for (int i = 0; i < sk_X509_INFO_num(x509_info); i++) {
        X509_INFO *x509_info_temp = sk_X509_INFO_value(x509_info, i);
        X509 *x509 = x509_info_temp -> x509;
        if (x509) {
            BioString bio_out;
            
            PEM_write_bio_X509(bio_out.get(), x509);
            
            std::string chain = bio_out.toString();
            
            chains.push_back(chain);
            
        }
    }
    
    return chains;
}

bool isSigned(const char* cert_pem) {
    
    BIO *bio = BIO_new(BIO_s_mem());
    BIO_puts(bio, cert_pem);
    X509 * x509 = PEM_read_bio_X509(bio, NULL, NULL, NULL);
    
    EVP_PKEY *pkey = X509_get_pubkey(x509);
    int result = X509_verify(x509, pkey);
    
    EVP_PKEY_free(pkey);
    BIO_free(bio);
    X509_free(x509);
    
    return result;
}

bool isRootCertificate(const char* cert_pem) {
    
    BIO *bio = BIO_new(BIO_s_mem());
    BIO_puts(bio, cert_pem);
    X509 * x509 = PEM_read_bio_X509(bio, NULL, NULL, NULL);
    
    EVP_PKEY *pkey = X509_get_pubkey(x509);
    
    ASN1_BIT_STRING *keyUsage = (ASN1_BIT_STRING *)X509_get_ext_d2i(x509, NID_key_usage, 0, 0);
    
    ASN1_BIT_STRING *basicConstraints = (ASN1_BIT_STRING *)X509_get_ext_d2i(x509, NID_basic_constraints, 0, 0);
    
    bool result = X509_verify(x509, pkey) && keyUsage != NULL && basicConstraints != NULL;
    
    EVP_PKEY_free(pkey);
    BIO_free(bio);
    X509_free(x509);
    
    return result;
}

bool isIntermediateCertificate(const char* cert_pem) {
    
    BIO *bio = BIO_new(BIO_s_mem());
    BIO_puts(bio, cert_pem);
    X509 * x509 = PEM_read_bio_X509(bio, NULL, NULL, NULL);
    
    EVP_PKEY *pkey = X509_get_pubkey(x509);
    
    ASN1_BIT_STRING *keyUsage = (ASN1_BIT_STRING *)X509_get_ext_d2i(x509, NID_key_usage, 0, 0);
    
    ASN1_BIT_STRING *basicConstraints = (ASN1_BIT_STRING *)X509_get_ext_d2i(x509, NID_basic_constraints, 0, 0);
    
    bool result = !X509_verify(x509, pkey) && keyUsage != NULL && basicConstraints != NULL;
    
    EVP_PKEY_free(pkey);
    BIO_free(bio);
    X509_free(x509);
    
    return result;
}


bool isClientCertificate(const char* cert_pem) {
    
    BIO *bio = BIO_new(BIO_s_mem());
    BIO_puts(bio, cert_pem);
    X509 * x509 = PEM_read_bio_X509(bio, NULL, NULL, NULL);
    
    EVP_PKEY *pkey = X509_get_pubkey(x509);
    
    ASN1_BIT_STRING *keyUsage = (ASN1_BIT_STRING *)X509_get_ext_d2i(x509, NID_key_usage, 0, 0);
    
    ASN1_BIT_STRING *basicConstraints = (ASN1_BIT_STRING *)X509_get_ext_d2i(x509, NID_basic_constraints, 0, 0);
    
    bool result = !X509_verify(x509, pkey) && keyUsage == NULL && basicConstraints == NULL;
    
    EVP_PKEY_free(pkey);
    BIO_free(bio);
    X509_free(x509);
    
    return result;
    
}

} //namespace transact_id_ssl
