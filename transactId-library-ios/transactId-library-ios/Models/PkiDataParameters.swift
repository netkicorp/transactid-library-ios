//
//  PkiDataParameters.swift
//  transactId-library-ios
//
//  Created by Developer on 09.02.2021.
//

import Foundation

/**
 * Pki data to be used to create a message.
 */
class PkiDataParameters {
    
    /**
     * Type of certificate.
     */
    var attestation: Attestation? = nil
    
    /**
     * PrivateKey in PEM format.
     */
    
    var privateKeyPem: String? = nil
    
    /**
     * Certificate in PEM format associated with PrivateKey.
     */
    var certificatePem: String? = nil
    
    
    /**
     * Type of the Pki data associated.
     */
    var type: PkiType = .NONE
}
