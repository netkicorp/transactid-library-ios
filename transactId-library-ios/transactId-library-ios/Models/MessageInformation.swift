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
public class MessageInformation {
    
    /**
     * Message Protocol Status Code.
     */
    public var statusCode: StatusCode = .ok
    
    /**
     * Human-readable Payment Protocol status message.
     */
    public var statusMessage: String = ""
    
    /**
     * Set to true if you want to encrypt message.
     */
    public var encryptMessage: Bool = false
    
}
