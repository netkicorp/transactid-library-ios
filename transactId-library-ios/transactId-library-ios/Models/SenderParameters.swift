//
//  SenderParameters.swift
//  transactId-library-ios
//
//  Created by Developer on 09.02.2021.
//

import Foundation

/**
 * Data of the sender of the message to be used to create a message.
 */
public class SenderParameters {
    
    /**
     * PkiData associated to the sender.
     */
    public var pkiDataParameters: PkiDataParameters? = nil
    
    /**
     * Parameters needed if you want to encrypt the protocol message.
     * If you add the parameters here, the encryption of the message will happen automatically.
     */
    public var encryptionParameters: EncryptionParameters? = nil
    
    /**
     * EV Certificate in PEM format.
     */
    public var evCertificatePem: String? = nil
    
    public init(pkiDataParameters: PkiDataParameters? = nil, evCertificatePem: String? = nil, encryptionParameters: EncryptionParameters? = nil) {
        self.pkiDataParameters = pkiDataParameters
        self.evCertificatePem = evCertificatePem
        self.encryptionParameters = encryptionParameters
    }
}
