//
//  OpenSSLEncryptionHelper.cpp
//  transactId-library-ios
//
//  Created by Developer on 15.03.2021.
//

#include "OpenSSLEncryptionHelper.h"
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
#include <vector>
#include <array>

namespace transact_id_ssl {

EncryptionData::EncryptionData() { }

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

std::string ecdh(EC_KEY* publicKey, EC_KEY* privateKey)
{
    int fieldSize = EC_GROUP_get_degree(EC_KEY_get0_group(privateKey));
    int ecdhSize = (fieldSize + 7) / 8;
    unsigned char ecdh[ecdhSize];
    ecdhSize = ECDH_compute_key(ecdh, ecdhSize, EC_KEY_get0_public_key(publicKey), privateKey, nullptr);
    if (ecdhSize <= 0) return nullptr;
    std::string str(reinterpret_cast<char*>(ecdh), ecdhSize);
    return str;
}

std::string hmac(unsigned char *key,
                 int keySize,
                 unsigned char * iv,
                 int ivSize,
                 unsigned char *publicKey,
                 int publicKeySize,
                 unsigned char *cipherText,
                 int cipherTextSize)
{

    OpenSSL_add_all_digests();

    EVP_MD_CTX*ctx = EVP_MD_CTX_create();

    EVP_PKEY *pkey = EVP_PKEY_new_mac_key(EVP_PKEY_HMAC, NULL, key, keySize);

    EVP_DigestSignInit(ctx, NULL, EVP_sha1(), NULL, pkey);

    EVP_DigestSignUpdate(ctx, iv, ivSize);
    EVP_DigestSignUpdate(ctx, publicKey, publicKeySize);
    EVP_DigestSignUpdate(ctx, cipherText, cipherTextSize);
    
    size_t hmacSize;
    unsigned char hmacResult[EVP_MAX_MD_SIZE];

    EVP_DigestSignFinal(ctx, hmacResult, &hmacSize);
    
    std::stringstream stream;

    for(unsigned int i = 0; i < hmacSize; ++i)
    {
        stream << std::hex << std::setw(2) << std::setfill('0') << (int)hmacResult[i];
    }
    return stream.str();
}

std::vector<char> hexToBytes(const std::string& hex)
{
    std::vector<char> bytes;
    
    for (unsigned int i = 0; i < hex.length(); i += 2)
    {
        std::string highByteString = hex.substr(i, 1);
        char highByte = (char) strtol(highByteString.c_str(), NULL, 16);
        std::string lowByteString = hex.substr(i+1, 1);
        char lowByte = (char) strtol(lowByteString.c_str(), NULL, 16);
        char byte = (int)highByte*16 + (int)lowByte;
        bytes.push_back(byte);
    }
    
    return bytes;
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
    if(1 != EVP_EncryptInit(ctx, EVP_aes_256_cbc(), key, iv)) return false;
        
    if(1 != EVP_EncryptUpdate(ctx, ciphertext, &len, plaintext, plaintextLength)) return false;
    chipperTextLength = len;
    
    if(1 != EVP_EncryptFinal(ctx, ciphertext+len, &len)) return false;
    
    chipperTextLength += len;
    
    EVP_CIPHER_CTX_free(ctx);
    
    return true;
}

bool encrypt(EncryptionData& data)
{
    
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
    
    if (1 != EC_POINT_get_affine_coordinates_GFp(EC_KEY_get0_group(publicKeySender), EC_KEY_get0_public_key(publicKeySender), x, y, nullptr)) return false;
    
    std::string publicKey = "04" + leftPadWithZeroes(BN_bn2hex(x)) + leftPadWithZeroes(BN_bn2hex(y));
    
    std::string sharedSecret = ecdh(publicKeyReceiver, privateKeySender);
    
    std::shared_ptr<EVP_MD_CTX> md(EVP_MD_CTX_create(), &EVP_MD_CTX_destroy);
    
    if (1 != EVP_DigestInit(md.get(), EVP_sha512())) return false;
    
    if (1 != EVP_DigestUpdate(md.get(), sharedSecret.c_str(), sharedSecret.size())) return false;
    
    unsigned int derivedKeySize = 0;
    char derivedKey[EVP_MAX_MD_SIZE];
    
    if (1 != EVP_DigestFinal(md.get(), (unsigned char *)derivedKey, &derivedKeySize)) return false;
    
    char encryptKey [derivedKeySize/2];
    char macKey [derivedKeySize/2];
    
    memcpy(encryptKey, &derivedKey[0], derivedKeySize/2);
    memcpy(macKey, &derivedKey[derivedKeySize/2], derivedKeySize/2);
    
    unsigned char iv[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
    
    int cipherTextSize = (int)data.message.length() + 16 - (int)data.message.length() % 16;
    
    unsigned char cipherText[cipherTextSize];
        
    if (!encrypt((unsigned char *)data.message.c_str(), static_cast<int>(data.message.length()), (unsigned char *)encryptKey, iv, cipherText, cipherTextSize)) return false;
    
    std::stringstream stream;

    for(unsigned int i = 0; i < cipherTextSize; ++i)
    {
        stream << std::uppercase << std::hex << std::setw(2) << std::setfill('0') << (int)cipherText[i];
    }

    std::string hexCipherText = stream.str();
    
    std::vector<char> hexPublicKey = hexToBytes(publicKey);
    
    std::string hexHmac = hmac((unsigned char *)macKey,
                               (int)sizeof(macKey),
                               (unsigned char *)iv,
                               (int)sizeof(iv),
                               (unsigned char *)hexPublicKey.data(),
                               (int)hexPublicKey.size(),
                               (unsigned char *)cipherText,
                               cipherTextSize);
    
    data.encryptedMessage = publicKey + hexHmac + hexCipherText;
        
    return true;
}

}
