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
}
