//
//  OpenSSLSigningHelper.cpp
//  transactId-library-ios
//
//  Created by Developer on 15.03.2021.
//

#include "OpenSSLSigningHelper.h"
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

namespace transact_id_ssl {

SignData::SignData(): base64(false) { }

std::vector<std::string> policies = {
    "2.16.840.1.114171.500.9",
    "1.2.392.200091.100.721.1",
    "1.3.6.1.4.1.6334.1.100.1",
    "2.16.528.1.1001.1.1.1.12.6.1.1.1",
    "2.16.756.1.89.1.2.1.1",
    "1.3.6.1.4.1.23223.2",
    "2.16.840.1.113733.1.7.23.6",
    "1.3.6.1.4.1.14370.1.6",
    "2.16.840.1.113733.1.7.48.1",
    "2.16.840.1.114404.1.1.2.4.1",
    "1.3.6.1.4.1.6449.1.2.1.5.1",
    "2.16.840.1.114413.1.7.23.3",
    "2.16.840.1.114412.2.1",
    "1.3.6.1.4.1.8024.0.2.100.1.2",
    "1.3.6.1.4.1.782.1.2.1.8.1",
    "2.16.840.1.114028.10.1.2",
    "1.3.6.1.4.1.4146.1.1"
};

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

bool signEc(std::shared_ptr<EVP_PKEY> key, SignData& data)
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
    
    
    unsigned char result [sz];
    ret = ECDSA_sign(0, hash, SHA256_DIGEST_LENGTH, reinterpret_cast<unsigned char*> (result),
                     &sz, eck);
        
    BioString bio(data.privateKey);
    bio.reset();

    std::shared_ptr<BIO> b64(BIO_new(BIO_f_base64()), &BIO_free);
    BIO_set_flags(b64.get(), BIO_FLAGS_BASE64_NO_NL);
    BIO_push(b64.get(), bio.get());
    BIO_write(b64.get(), result, sz);
    BIO_flush(b64.get());
    BIO_pop(b64.get());
    data.signature = bio.toString();
    
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
        case EVP_PKEY_RSA:
            if (!signRsa(key, data, sig)) {
                return false;
                break;
            } else {
                if (data.base64)
                {
                    std::shared_ptr<BIO> b64(BIO_new(BIO_f_base64()), &BIO_free);
                    BIO_set_flags(b64.get(), BIO_FLAGS_BASE64_NO_NL);
                    BIO_push(b64.get(), bio.get());
                    BIO_write(b64.get(), sig.data(), static_cast<int> (sig.size()));
                    BIO_flush(b64.get());
                    BIO_pop(b64.get());
                    data.signature = bio.toString();
                } else {
                    data.signature = sig;
                }
            }
        case EVP_PKEY_EC:
            if (!signEc(key, data)) {
                return false;
                break;
            }
        default: data.errorInfo = "Invalid public key format"; return false;
    }
    return true;
}

std::string hash256(unsigned char * data, size_t dataSize)
{
    
    int ret = 0;
    
    std::string sig;
    
    std::shared_ptr<EVP_MD_CTX> md(EVP_MD_CTX_create(), &EVP_MD_CTX_destroy);
    
    ret = EVP_DigestInit(md.get(), EVP_sha256());
    if (ret != 1) { return nullptr; }
    
    ret = EVP_DigestUpdate(md.get(), data, dataSize);
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
        
    bool result = X509_verify(x509, pkey) && (keyUsage->data != NULL && ASN1_BIT_STRING_get_bit(keyUsage, 5) != 0) && basicConstraints->data != NULL;

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
        
    bool result = !X509_verify(x509, pkey) && (keyUsage->data != NULL && ASN1_BIT_STRING_get_bit(keyUsage, 5) != 0) && basicConstraints->data != NULL;

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
    
    bool result = !X509_verify(x509, pkey) && (keyUsage == NULL || ASN1_BIT_STRING_get_bit(keyUsage, 5) == 0) && (basicConstraints == NULL || basicConstraints->data == NULL);
    
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

bool isEvCertificate(const char* cert_pem) {
    BIO *bio = BIO_new(BIO_s_mem());
    BIO_puts(bio, cert_pem);
    X509* x509 = PEM_read_bio_X509(bio, NULL, 0, NULL);
    
    STACK_OF(POLICYINFO) * infos =(STACK_OF(POLICYINFO) *)X509_get_ext_d2i(x509, NID_certificate_policies, NULL, NULL);

    for (int i = 0; i < sk_POLICYINFO_num(infos); i++)
    {
        POLICYINFO *policyInfo = sk_POLICYINFO_value(infos, i);

        ASN1_OBJECT *policyid = policyInfo->policyid;
        
        std::string oid(80, 0);
        oid.resize(size_t(OBJ_obj2txt(&oid[0], int(oid.size()), policyid, 1)));
        
        for (int j = 0; j < policies.size(); j++) {
            if (oid == policies[j]) {
                return true;
            }
        }
    }
    
    return false;
}


bool validateSignatureECDSA(unsigned char * original, size_t originalSize, std::string publicKey, std::string data) {
    
    BioString bio(publicKey);
    EVP_PKEY* key = nullptr;
    
    PEM_read_bio_PUBKEY(bio.get(), &key, 0, 0);
    
    if (key == nullptr) {  return false; }

    std::shared_ptr<EVP_PKEY> evpKey(key, &EVP_PKEY_free);
    bio.reset();

    EVP_MD_CTX*ctx = EVP_MD_CTX_create();

    EVP_VerifyInit(ctx, EVP_sha256());
    EVP_VerifyUpdate(ctx, (unsigned char *)data.c_str(), data.length());
    if (1 != EVP_VerifyFinal(ctx, original , (int)originalSize, evpKey.get())) {
        return false;
    }
    
    return true;
}

bool validateSignature(unsigned char * original, size_t originalSize, const char* certificate, std::string data) {
    
    BIO *bio = BIO_new(BIO_s_mem());
    BIO_puts(bio, certificate);
    X509* x509 = X509_new();
    PEM_read_bio_X509(bio, &x509, NULL, NULL);
    
    EVP_PKEY *pkey = X509_get_pubkey(x509);

    EVP_MD_CTX*ctx = EVP_MD_CTX_create();

    EVP_VerifyInit(ctx, EVP_sha256());
    EVP_VerifyUpdate(ctx, (unsigned char *)data.c_str(), data.length());
    if (1 != EVP_VerifyFinal(ctx, original , (int)originalSize, pkey)) {
        return false;
    }
    
    EVP_PKEY_free(pkey);
    BIO_free(bio);
    X509_free(x509);
    
    return true;
}


}
