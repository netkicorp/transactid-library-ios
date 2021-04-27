//
//  ProtocolMessageMetadata.swift
//  transactId-library-ios
//
//  Created by Developer on 22.03.2021.
//

import Foundation

public class ProtocolMessageMetadata {
    
    /**
     * Protocol version number.
     */
    public var version: Int? = nil
    
    /**
     * Message Protocol Status Code.
     */
    public var statusCode: StatusCode? = .ok
    
    /**
     * Message Type of serialized_message.
     */
    public var messageType: MessageType? = .unknownMessageType
    
    /**
     * Human-readable Payment Protocol status message
     */
    public var statusMessage: String? = nil
    
    /**
     * Unique key to identify this entire exchange on the server. Default value SHOULD be SHA256(Serialized Initial InvoiceRequest + Current Epoch Time in Seconds as a String)
     */
    public var identifier: String? = nil
    
    /**
     * True if the message is encrypted, false otherwise.
     */
    public var encrypted: Bool = false
    
    /**
     * AES-256-GCM Encrypted (as defined in BIP75) Payment Protocol Message.
     */
    public var encryptedMessage: String? = nil
    
    /**
     * Recipient's SEC-encoded EC Public Key.
     */
    public var recipientPublicKeyPem: String? = nil
    
    /**
     * Sender's SEC-encoded EC Public Key.
     */
    public var senderPublicKeyPem: String? = nil
    
    /**
     * Microseconds since epoch.
     */
    public var nonce: Int? = nil
    
    /**
     * DER-encoded Signature over the full EncryptedProtocolMessage with EC Key Belonging to Sender / Recipient, respectively.
     */
    public var signature: String? = nil
}
