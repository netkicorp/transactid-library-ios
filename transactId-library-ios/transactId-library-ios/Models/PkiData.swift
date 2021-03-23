//
//  PkiData.swift
//  transactId-library-ios
//
//  Created by Developer on 23.03.2021.
//

import Foundation

/**
 * Pki data in a message.
 */

class PkiData {
    
    /**
     * Type of certificate.
     */
    var attestation: Attestation? = nil
    
    /**
     * Certificate in PEM format associated with PrivateKey.
     */
    var certificate: String = ""
    
    /**
     * Pki type.
     */
    var pkiType: PkiType? = nil
    
    /**
     * Signature created with this attestation.
     */
    var signature: String = ""
}
