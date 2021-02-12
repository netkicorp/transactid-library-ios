//
//  MessageInformation.swift
//  transactId-library-ios
//
//  Created by Developer on 09.02.2021.
//

import Foundation

/**
 *  Status code and Status message that is used for error communication
 *  such that the protocol does not rely on transport-layer error handling.
 */
class MessageInformation {
    
    /**
     * Message Protocol Status Code.
     */
    var statusCode: StatusCode = .OK
    
    /**
     * Human-readable Payment Protocol status message.
     */
    var statusMessage: String = ""
    
    /**
     * Set to true if you want to encrypt message.
     */
    var encryptMessage: Bool = false
    
}
