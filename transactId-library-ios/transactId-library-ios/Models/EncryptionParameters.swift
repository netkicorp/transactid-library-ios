//
//  EncryptionParameters.swift
//  transactId-library-ios
//
//  Created by Developer on 09.02.2021.
//

import Foundation

/**
 * Parameters to encrypt message, this is needed if you want to create the EncryptedProtocolMessage.
 */
public class EncryptionParameters {
    
    /**
     * SEC-encoded EC Private Key in PEM format.
     */
    var privateKeyPem: String? = nil
    
    /**
     * SEC-encoded EC Public Key in PEM format.
     */
    var publicKeyPem: String? = nil
    
    public init(privateKeyPem: String? = nil, publicKeyPem: String? = nil) {
        self.privateKeyPem = privateKeyPem
        self.publicKeyPem = publicKeyPem
    }
}
