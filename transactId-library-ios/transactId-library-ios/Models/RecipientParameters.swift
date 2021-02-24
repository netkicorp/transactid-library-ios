//
//  RecipientParameters.swift
//  transactId-library-ios
//
//  Created by Developer on 09.02.2021.
//

import Foundation

/**
 * Data of the recipient of the message to be used to create a message.
 */
public class RecipientParameters {
    
    /**
     * Recipient's vasp name.
     */
    var vaspName: String? = nil
    
    /**
     * Recipient's vasp name.
     */
    var chainAddress: String? = nil
    
    /**
     * Parameters needed if you want to encrypt the protocol message.
     * If you add the parameters here, the encryption of the message will happen automatically.
     */
    var encryptionParameters: EncryptionParameters? = nil
}
