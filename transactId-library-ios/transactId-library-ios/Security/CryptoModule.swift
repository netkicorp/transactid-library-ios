//
//  CryptoModule.swift
//  transactId-library-ios
//
//  Created by Developer on 02.02.2021.
//

import Foundation

class CryptoModule {
    
    init() { }
    
    func sign(privateKeyPem: String, messageData: Data) -> Data? {
        let hash = OpenSSLTools().hash256(messageData)
        return OpenSSLTools().sign(privateKeyPem, message: hash, newLine: false)
    }
    
    /**
     * Generate identifier for an specific message in ByteArray format
     */
    
    func generateIdentifier(message: Data) -> String {
        let hash = OpenSSLTools().hash256(message)
        let epochTime = Int(Date().timeIntervalSince1970)
        return "\(hash)\(epochTime)"
    }
        
    func encrypt(message: String,
                 receiverPublicKeyPem: String,
                 senderPublicKeyPem: String,
                 senderPrivateKeyPem: String) throws -> String {
        
        return OpenSSLTools().encrypt(message,
                                      receiverPublicKey: receiverPublicKeyPem,
                                      senderPublicKey: senderPublicKeyPem,
                                      senderPrivateKey: senderPrivateKeyPem)
    }
    
    func decrypt(encryptedMessage: String,
                 receiverPrivateKeyPem: String,
                 senderPublicKeyPem: String) throws -> String {
        
        return OpenSSLTools().decrypt(encryptedMessage, receiverPrivateKey: receiverPrivateKeyPem, senderPublicKey: senderPublicKeyPem)
    }
    
    /**
     * Validate if a signature is valid with ECDSA public key.
     *
     * @param signature to validate.
     * @param data that was signed.
     * @param publicKey to validate the signature.
     * @return true if is valid, false otherwise.
     */
    
    func validateSignatureECDSA(signature: String, data: Data, publicKeyPem: String) -> Bool {
        let hash = OpenSSLTools().hash256(data)
        return OpenSSLTools().validateSignatureECDSA(signature, publicKey: publicKeyPem, data: hash)
    }
    
    /**
     * Validate if a signature is valid.
     *
     * @param signature to validate.
     * @param data that was signed.
     * @param certificatePem in PEM format to validate the signature.
     * @return true if is valid, false otherwise.
     */
    
    func validateSignature(signature: String, data: Data, certificate: String?) -> Bool {
        guard let certificate = certificate else {
            return false
        }
        let hash = OpenSSLTools().hash256(data)
        return OpenSSLTools().validateSignature(signature, certificate: certificate, data: hash)
    }
    
    /**
     * Extract client certificate from Certificates in PEM format.
     *
     * @param certificatesPem string.
     * @return Client certificate in PEM format.
     */
    
    func certificatePemToClientCertificate(certificatesPem: String?) -> String? {
        if let certificatesPem = certificatesPem {
            if let certificates = self.pemCertificatesToArray(certificatesPem: certificatesPem) {
                return self.getClientCertificate(certificates: certificates)
            }
        }
        return nil
    }
    
    /**
     * Convert certificates in PEM format to Array of PEM.
     *
     * @param certificatesPem string.
     * @return Array of PEM certificates.
     */
    private func pemCertificatesToArray(certificatesPem: String) -> Array<String>? {
        if let certificates = OpenSSLTools().pem(toCertificatesArray: certificatesPem) as NSArray as? [String] {
            return certificates
        }
        return nil
    }
    
    /**
     * Extract client certificate from a array of certificates.
     *
     * @param certificates including the client certificate.
     * @return Client certificate.
     */
    func getClientCertificate(certificates: Array<String>) -> String? {
        return certificates.first(where: { OpenSSLTools().isClientCertificate($0) })
    }
    
    
}
