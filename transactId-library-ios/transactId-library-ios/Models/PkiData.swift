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

public class PkiData {
    
    /**
     * Type of certificate.
     */
    public var attestation: Attestation? = nil
    
    /**
     * Certificate in PEM format associated with PrivateKey.
     */
    public var certificate: String = ""
    
    /**
     * Pki type.
     */
    public var pkiType: PkiType? = nil
    
    /**
     * Signature created with this attestation.
     */
    public var signature: String = ""
}
