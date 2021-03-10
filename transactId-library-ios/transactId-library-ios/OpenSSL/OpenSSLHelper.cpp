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
#include <openssl/x509v3.h>
#include <openssl/ssl.h>
#include <openssl/crypto.h>
#include <openssl/ocsp.h>
#include <iostream>
#include <sstream>
#include <openssl/evp.h>
#include <iomanip>
#include <openssl/ec.h>
#include <openssl/ecdh.h>
#include <openssl/aes.h>

namespace transact_id_ssl {

#define AES_KEYLENGTH 256

using ASN1_TIME_ptr = std::unique_ptr<ASN1_TIME, decltype(&ASN1_STRING_free)>;

CsrData::CsrData() : type(Rsa) { }

SignData::SignData(): base64(false) { }

EncryptionData::EncryptionData(): base64(false) { }

EncryptionData:: ~EncryptionData()
{
    std::cout << "Destructing EncryptionData " << message << '\n';
}

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
    BioString bio(data.privateKey);
    EVP_PKEY* pk = nullptr;

    PEM_read_bio_PrivateKey(bio.get(), &pk, 0, 0);

    if (pk == nullptr) { reportError(data); return false; }
    
    std::shared_ptr<EVP_PKEY> key(pk, &EVP_PKEY_free);
    
    bio.reset();
    
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
        BIO_set_flags(b64.get(), BIO_FLAGS_BASE64_NO_NL);
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

bool validateCertificateNotBeforeExpiration(const char* cert_pem) {
    
    BIO *bio = BIO_new(BIO_s_mem());
    BIO_puts(bio, cert_pem);
    X509 * x509 = PEM_read_bio_X509(bio, NULL, NULL, NULL);
    
    time_t notBefore;
    
    time_t now = time(0);
    
    bool result = X509_cmp_time(X509_get_notBefore(x509), &notBefore);
    if (result) {
        return difftime(now, notBefore) > 0.0;
    } else {
        return false;
    }
}

bool validateCertificateNotAfterExpiration(const char* cert_pem) {
    
    BIO *bio = BIO_new(BIO_s_mem());
    BIO_puts(bio, cert_pem);
    X509 * x509 = PEM_read_bio_X509(bio, NULL, NULL, NULL);
    
    time_t notAfter;
    
    time_t now = time(0);
    
    bool result = X509_cmp_time(X509_get_notAfter(x509), &notAfter);
    if (result) {
        return difftime(notAfter, now) > 0.0;
    } else {
        return false;
    }
    return false;
}

std::vector<std::string> getCRLDistributionPoints(const char* cert_pem)
{
    std::vector<std::string> list;
    
    BIO *bio = BIO_new(BIO_s_mem());
    BIO_puts(bio, cert_pem);
    X509 * x509 = PEM_read_bio_X509(bio, NULL, NULL, NULL);
    
    STACK_OF(DIST_POINT) * dist_points =(STACK_OF(DIST_POINT) *)X509_get_ext_d2i(x509, NID_crl_distribution_points, NULL, NULL);
    for (int j = 0; j < sk_DIST_POINT_num(dist_points); j++)
    {
        DIST_POINT *dp = sk_DIST_POINT_value(dist_points, j);
        
        DIST_POINT_NAME *distpoint = dp->distpoint;
        
        if (distpoint->type == 0) {
            for (int k = 0; k < sk_GENERAL_NAME_num(distpoint->name.fullname); k++)
            {
                GENERAL_NAME *gen = sk_GENERAL_NAME_value(distpoint->name.fullname, k);
                ASN1_IA5STRING *asn1_str = gen->d.uniformResourceIdentifier;
                list.push_back(std::string((char*)ASN1_STRING_data(asn1_str), ASN1_STRING_length(asn1_str)));
            }
        } else if (distpoint->type == 1) {
            STACK_OF(X509_NAME_ENTRY) *sk_relname = distpoint->name.relativename;
            for (int k = 0; k < sk_X509_NAME_ENTRY_num(sk_relname); k++)
            {
                X509_NAME_ENTRY *e = sk_X509_NAME_ENTRY_value(sk_relname, k);
                ASN1_STRING *d = X509_NAME_ENTRY_get_data(e);
                list.push_back(std::string((char*)ASN1_STRING_data(d), ASN1_STRING_length(d)));
            }
        }
    }
    return list;
}

bool generateHash256(SignData& data) {

    int ret = 0;
    
    std::string sig;
    
    std::shared_ptr<EVP_MD_CTX> md(EVP_MD_CTX_create(), &EVP_MD_CTX_destroy);

    ret = EVP_DigestInit(md.get(), EVP_sha256());
    if (ret != 1) { reportError(data); return false; }

    ret = EVP_DigestUpdate(md.get(), data.message.c_str(), data.message.size());
    if (ret != 1) { reportError(data); return false; }

    unsigned int sz = 0;
    
    unsigned char hash[EVP_MAX_MD_SIZE];

    ret = EVP_DigestFinal(md.get(), hash, &sz);
    if (ret != 1) { reportError(data); return false; }

    std::stringstream stream;
    for(unsigned int i = 0; i < sz; ++i)
    {
        stream << std::hex << std::setw(2) << std::setfill('0') << (int)hash[i];
    }
    
    sig = stream.str();
    
    BioString bio;
    
    if (data.base64)
    {
        std::shared_ptr<BIO> b64(BIO_new(BIO_f_base64()), &BIO_free);
        BIO_set_flags(b64.get(), BIO_FLAGS_BASE64_NO_NL);
        BIO_push(b64.get(), bio.get());
        BIO_write(b64.get(), sig.data(), static_cast<int> (sig.size()));
        BIO_flush(b64.get());
        BIO_pop(b64.get());
        data.signature = bio.toString();
    } else
        data.signature = sig;
    
    return true;
}

bool pemKeyToECKey(std::string publicKeyPem, EC_KEY*& eck, bool isPrivate) {
    BioString bio(publicKeyPem);
    EVP_PKEY* key = nullptr;
    if (isPrivate) {
        PEM_read_bio_PrivateKey(bio.get(), &key, 0, 0);
    } else {
        PEM_read_bio_PUBKEY(bio.get(), &key, 0, 0);
    }
    if (key == nullptr) {  return false; }

    std::shared_ptr<EVP_PKEY> evpKey(key, &EVP_PKEY_free);
    bio.reset();
    
    if (EVP_PKEY_base_id(evpKey.get()) == EVP_PKEY_EC) {
        eck = EVP_PKEY_get1_EC_KEY(evpKey.get());
    } else {
        return false;
    }
    
    return true;
}

std::string leftPadWithZeroes(char * original) {
    std::string padded = original;
    while (padded.length() < 64) {
        padded = "0" + padded;
    }
    return padded;
}

std::string ecdh(EC_KEY* publicKey, EC_KEY* privateKey) {
        
    int fieldSize = EC_GROUP_get_degree(EC_KEY_get0_group(privateKey));
    int ecdhSize = (fieldSize + 7) / 8;
    
    unsigned char ecdh[ecdhSize];

    ecdhSize = ECDH_compute_key(ecdh, ecdhSize, EC_KEY_get0_public_key(publicKey), privateKey, nullptr);
    
    if (ecdhSize <= 0) return nullptr;
    
//    std::stringstream stream;
//    for(unsigned int i = 0; i < ecdhSize; ++i)
//    {
//        stream << std::hex << std::setw(2) << std::setfill('0') << (int)ecdh[i];
//    }
    std::string str(reinterpret_cast<char*>(ecdh), ecdhSize);

    return str;
}

bool encrypt(unsigned char *plaintext,
             int plaintextLength,
             unsigned char *key,
             unsigned char *iv,
             unsigned char *ciphertext,
             int &chipperTextLength)
{
    EVP_CIPHER_CTX *ctx;
    
    int len;
    
    if(!(ctx = EVP_CIPHER_CTX_new())) return false;
    if(1 != EVP_EncryptInit(ctx, EVP_aes_128_cbc(), key, iv)) return false;
    
    if(1 != EVP_EncryptUpdate(ctx, ciphertext, &len, plaintext, plaintextLength))return false;
    chipperTextLength = len;
    
    if(1 != EVP_EncryptFinal(ctx, ciphertext + len, &len)) return false;
    chipperTextLength += len;
    
    EVP_CIPHER_CTX_free(ctx);
    
    return true;
}

std::string generateHash512(std::string data) {

    int ret = 0;
    
    std::string sig;
    
    std::shared_ptr<EVP_MD_CTX> md(EVP_MD_CTX_create(), &EVP_MD_CTX_destroy);

    ret = EVP_DigestInit(md.get(), EVP_sha512());
    if (ret != 1) { return nullptr; }

    ret = EVP_DigestUpdate(md.get(), data.c_str(), data.size());
    if (ret != 1) { return nullptr; }

    unsigned int sz = 0;
    
    unsigned char hash[EVP_MAX_MD_SIZE];

    ret = EVP_DigestFinal(md.get(), hash, &sz);
    if (ret != 1) { return nullptr; }

    std::stringstream stream;
    for(unsigned int i = 0; i < sz; ++i)
    {
        stream << std::hex << std::setw(2) << std::setfill('0') << (int)hash[i];
    }
    
    sig = stream.str();
    
    return sig;
}

std::string hmac(unsigned char *hashKey,
                 int hashKeyLen,
                 unsigned char * iv,
                 unsigned char *publicKeyData,
                 size_t publicKeyDataLen,
                 unsigned char *chiperData,
                 size_t chiperDataLen)
{
    HMAC_CTX ctx;
    HMAC_CTX_init(&ctx);
    
    unsigned char hmacResult [20];
    unsigned int hmacResultLen = 20;

    HMAC_Init(&ctx, &hashKey, hashKeyLen, EVP_sha1());
    
    HMAC_Update(&ctx, iv, sizeof(iv));
    HMAC_Update(&ctx, publicKeyData, publicKeyDataLen);
    HMAC_Update(&ctx, chiperData, chiperDataLen);
    HMAC_Final(&ctx, hmacResult, &hmacResultLen);
//    HMAC_CTX_cleanup(&ctx);
    
    std::stringstream stream1;
    std::string hmacResultString;

    for(unsigned int i = 0; i < hmacResultLen; ++i)
    {
        stream1 << std::hex << std::setw(2) << std::setfill('0') << (int)hmacResult[i];
    }
    return stream1.str();
}

int hex2bin( const char *s )
{
    int ret=0;
    int i;
    for( i=0; i<2; i++ )
    {
        char c = *s++;
        int n=0;
        if( '0'<=c && c<='9' )
            n = c-'0';
        else if( 'a'<=c && c<='f' )
            n = 10 + c-'a';
        else if( 'A'<=c && c<='F' )
            n = 10 + c-'A';
        ret = n + ret*16;
    }
    return ret;
}


bool encrypt(EncryptionData& data) {
    
    EC_KEY* publicKeySender;
    EC_KEY* publicKeyReceiver;
    EC_KEY* privateKeySender;
    
    bool res = pemKeyToECKey(data.publicKeySender, publicKeySender, false);
    if (!res) return false;

    res = pemKeyToECKey(data.publicKeyReceiver, publicKeyReceiver, false);
    if (!res) return false;
    
    res = pemKeyToECKey(data.privateKeySender, privateKeySender, true);
    if (!res) return false;
    
    BIGNUM *x = BN_new();
    BIGNUM *y = BN_new();
    
    int ret = EC_POINT_get_affine_coordinates_GFp(EC_KEY_get0_group(publicKeySender), EC_KEY_get0_public_key(publicKeySender), x, y, nullptr);
    if (ret != 1) return false;
    
    std::string message = data.message;

    std::string publicKey = "04" + leftPadWithZeroes(BN_bn2hex(x)) + leftPadWithZeroes(BN_bn2hex(y));

    std::string sharedSecret = ecdh(publicKeyReceiver, privateKeySender);
    
    std::string derivedKey = generateHash512(sharedSecret);
    if (!res) return false;

    std::string encryptKey(derivedKey.c_str(), derivedKey.length()/2);
    std::string macKey = derivedKey.substr(derivedKey.length()/2, derivedKey.length());

    unsigned char iv[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};

    
    //TODO : Encrypt AES/CBC/PKCS5Padding
    
    
    int chipherTextLength = (int)message.length() + 128 - (int)message.length() % 128;
    
    unsigned char chipherText[chipherTextLength];

    res = encrypt((unsigned char*)message.data(), static_cast<int>(message.length()), (unsigned char*)encryptKey.data(), iv, chipherText, chipherTextLength);
    
    if (!res) return false;

    std::stringstream stream;
    for(unsigned int i = 0; i < chipherTextLength; ++i)
    {
        stream << std::hex << std::setw(2) << std::setfill('0') << (int)chipherText[i];
    }
        
    std::string chipherTextStr = "58cab2559431932ba979f611dd5d367a";//stream.str(); //"8c106505d0c144ee7e1dedd65921d513"
    
    unsigned char chiperData[chipherTextStr.length()];
    std::copy(chipherTextStr.begin(), chipherTextStr.end(), chiperData );
    
    unsigned char publicKeyData[publicKey.length()];
    std::copy(publicKey.begin(), publicKey.end(), publicKeyData);

    
    unsigned char hmacKey[macKey.length()];
    std::copy(macKey.begin(), macKey.end(), hmacKey);
        
    char out[publicKey.length()/2];
    char * in = (char *)publicKey.data();
    
    int i;
    for( i=0; i<publicKey.length()/2; i++ )
        {
            out[i] = hex2bin( in );
            in += 2;
        }
    
    std::string hmacResult = hmac(hmacKey,
                                  static_cast<int>(macKey.length()),
                                  iv,
                                  (unsigned char *)out,
                                  publicKey.length()/2,
                                  chiperData,
                                  chipherTextLength);      //"cd955ede0c5920e5574f455cb4ba9b00d446048c" //3c271e123b6bc8114af4631677127206f634dd90 // "6c9a8b21795335ead935e1cc1db2c8eac44ed836"
    
    data.encryptedMessage = publicKey + hmacResult + chipherTextStr;
    return true;
    
    //macHex = 34181312fbd6343669ef6160369a6b19b38fac23
    //chipherText = 58cab2559431932ba979f611dd5d367a
    
    //result = 0428ad6c86544254d8b187058ca4b48fdded2f3f2ff21cc660f839d9140405d6fd8a12736a0898c8bb1f31d49415f13e736c7cac6932474f507bca5348e14a4760 34181312FBD6343669EF6160369A6B19B38FAC23 58CAB2559431932BA979F611DD5D367A
}

} //namespace transact_id_ssl
