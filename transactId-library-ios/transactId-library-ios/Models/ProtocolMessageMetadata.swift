//
//  ProtocolMessageMetadata.swift
//  transactId-library-ios
//
//  Created by Developer on 22.03.2021.
//

import Foundation

class ProtocolMessageMetadata {
    
    /**
     * Protocol version number.
     */
    var version: Int? = nil
    
    /**
     * Message Protocol Status Code.
     */
    var statusCode: StatusCode? = .ok
    
    /**
     * Message Type of serialized_message.
     */
    var messageType: MessageType? = .unknownMessageType
    
    /**
     * Human-readable Payment Protocol status message
     */
    var statusMessage: String? = nil
    
    /**
     * Unique key to identify this entire exchange on the server. Default value SHOULD be SHA256(Serialized Initial InvoiceRequest + Current Epoch Time in Seconds as a String)
     */
    var identifier: String? = nil
    
    /**
     * True if the message is encrypted, false otherwise.
     */
    var encrypted: Bool = false
    
    /**
     * AES-256-GCM Encrypted (as defined in BIP75) Payment Protocol Message.
     */
    var encryptedMessage: String? = nil
    
    /**
     * Recipient's SEC-encoded EC Public Key.
     */
    var recipientPublicKeyPem: String? = nil
    
    /**
     * Sender's SEC-encoded EC Public Key.
     */
    var senderPublicKeyPem: String? = nil
    
    /**
     * Microseconds since epoch.
     */
    var nonce: Int? = nil
    
    /**
     * DER-encoded Signature over the full EncryptedProtocolMessage with EC Key Belonging to Sender / Recipient, respectively.
     */
    var signature: String? = nil
}
