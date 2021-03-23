//
//  Data+Extension.swift
//  transactId-library-ios
//
//  Created by Developer on 01.03.2021.
//

import Foundation

extension Data {

    /**
     * Transform a message in ByteArray to ProtocolMessage
     */
    func toProtocolMessageData(messageType: ProtocolMessageType,
                           messageInformation: MessageInformation,
                           senderParameters: SenderParameters? = nil,
                           recipientParameters: RecipientParameters? = nil) throws -> Data? {
        if messageInformation.encryptMessage {
            return try self.toProtocolMessageEncrypted(messageType: messageType,
                                                       messageInformation: messageInformation,
                                                       senderParameters: senderParameters,
                                                       recipientParameters: recipientParameters)?.serializedData()
        } else {
            return try self.toProtocolMessageUnencrypted(messageType: messageType,
                                                         messageInformation: messageInformation).serializedData()
        }
    }
    

    /**
     * Transform a message in ByteArray to EncryptedProtocolMessage
     */
    func toProtocolMessageEncrypted(messageType: ProtocolMessageType,
                                    messageInformation: MessageInformation,
                                    senderParameters: SenderParameters? = nil,
                                    recipientParameters: RecipientParameters? = nil) throws -> EncryptedProtocolMessage? {
        
        guard let recipientPublicKey = recipientParameters?.encryptionParameters?.publicKeyPem else {
            throw Exception.EncryptionException(ExceptionMessages.encryptionMissingRecipientKeysError)
        }
        
        guard let senderPublicKey = senderParameters?.encryptionParameters?.publicKeyPem,
              let senderPrivateKey = senderParameters?.encryptionParameters?.privateKeyPem else {
            throw Exception.EncryptionException(ExceptionMessages.encryptionMissingSenderKeysError)
        }
        
        let message = self.base64EncodedString()
        
        let encryptedMessage = try CryptoModule().encrypt(message: message,
                                                          receiverPublicKeyPem: recipientPublicKey,
                                                          senderPublicKeyPem: senderPublicKey,
                                                          senderPrivateKeyPem: senderPrivateKey)
        
        var protocolMessage = EncryptedProtocolMessage()
        protocolMessage.version = 1
        protocolMessage.statusCode = UInt64(messageInformation.statusCode.rawValue)
        protocolMessage.protocolMessageType = messageType
        protocolMessage.statusMessage = messageInformation.statusMessage
        protocolMessage.identifier = CryptoModule().generateIdentifier(message: self).toByteString()
        protocolMessage.receiverPublicKey = recipientPublicKey.toByteString()
        protocolMessage.senderPublicKey = senderPublicKey.toByteString()
        protocolMessage.nonce = UInt64(Date().timeIntervalSince1970)
        protocolMessage.encryptedMessage = encryptedMessage.toByteString()
        protocolMessage.signature = "".toByteString()
        
        do {
            var protocolMessageSigned = EncryptedProtocolMessage()
            let serializedData = try protocolMessage.serializedData()
                                    
            if let signature = CryptoModule().sign(privateKeyPem: senderPrivateKey, messageData: serializedData) {
                try protocolMessageSigned.merge(serializedData: serializedData)
                protocolMessageSigned.signature = signature
            }
            
            return protocolMessageSigned
            
        } catch let exception {
            print("Require Signature Exception: \(exception)")
            return nil
        }
    }
    
    /**
     * Transform a message in ByteArray to ProtocolMessage
     */
    func toProtocolMessageUnencrypted(messageType: ProtocolMessageType,
                                      messageInformation: MessageInformation) -> ProtocolMessage {
        
        var protocolMessage = ProtocolMessage()
        protocolMessage.version = 1
        protocolMessage.statusCode = UInt64(messageInformation.statusCode.rawValue)
        protocolMessage.protocolMessageType = messageType
        protocolMessage.serializedMessage = self
        protocolMessage.statusMessage = messageInformation.statusMessage
        protocolMessage.identifier = CryptoModule().generateIdentifier(message: self).toByteString()
        
        return protocolMessage
        
    }
    
    func toByteArray() -> Data {
        let byteArray : [UInt8] = self.withUnsafeBytes ({ (ptr : UnsafeRawBufferPointer) in
            [UInt8](UnsafeRawBufferPointer(start: ptr.baseAddress, count: self.count))
        })
        
        return Data(byteArray)
    }
    
    func toString() -> String? {
        return String(data: self, encoding: .utf8)
    }
    
    /**
     * Method to extract the ProtocolMessageMetadata from a Messages.ProtocolMessage
     */
    
    func extractProtocolMessageMetadata() throws -> ProtocolMessageMetadata? {

        do {
            let protocolMessage = try EncryptedProtocolMessage(serializedData: self)
            
            let protocolMessageMetadata = ProtocolMessageMetadata()
            protocolMessageMetadata.version = Int(protocolMessage.version)
            protocolMessageMetadata.statusCode = StatusCode(rawValue: Int(protocolMessage.statusCode))
            protocolMessageMetadata.messageType = MessageType(rawValue: protocolMessage.protocolMessageType.rawValue)
            protocolMessageMetadata.statusMessage = protocolMessage.statusMessage
            protocolMessageMetadata.identifier = protocolMessage.identifier.toString()
            protocolMessageMetadata.encrypted = true
            protocolMessageMetadata.encryptedMessage = protocolMessage.encryptedMessage.toString()
            protocolMessageMetadata.recipientPublicKeyPem = protocolMessage.receiverPublicKey.toString()
            protocolMessageMetadata.senderPublicKeyPem = protocolMessage.senderPublicKey.toString()
            protocolMessageMetadata.nonce = Int(protocolMessage.nonce)
            protocolMessageMetadata.signature = protocolMessage.signature.toString()
            
            return protocolMessageMetadata
            
        } catch {
            // nothing to do here
        }
        
        do {
            let protocolMessage = try ProtocolMessage(serializedData: self)
            
            let protocolMessageMetadata = ProtocolMessageMetadata()
            protocolMessageMetadata.version = Int(protocolMessage.version)
            protocolMessageMetadata.statusCode = StatusCode(rawValue: Int(protocolMessage.statusCode))
            protocolMessageMetadata.messageType = MessageType(rawValue: protocolMessage.protocolMessageType.rawValue)
            protocolMessageMetadata.statusMessage = protocolMessage.statusMessage
            protocolMessageMetadata.identifier = protocolMessage.identifier.toString()
            protocolMessageMetadata.encrypted = false
            
            return protocolMessageMetadata
            
        } catch let exception {
            throw Exception.InvalidObjectException(String(format: ExceptionMessages.parseBinaryMessageInvalidInput, exception.localizedDescription))
        }
    }
    
    /**
     * Method to extract serialized message from Messages.ProtocolMessage
     */
    func getSerializedMessage(encrypted: Bool, recipientParameters: RecipientParameters? = nil) throws -> Data? {
        if encrypted {
            return try self.getSerializedMessageEncryptedProtocolMessage(recipientParameters: recipientParameters)
        } else {
            return try self.getSerializedMessageProtocolMessage()
        }
    }
    
    /**
     * Method to extract serialized message from Messages.ProtocolMessage
     */
    func getSerializedMessageProtocolMessage() throws -> Data? {
        do {
            let protocolMessage = try ProtocolMessage(serializedData: self)
            return protocolMessage.serializedMessage.toByteArray()
        } catch let exception {
            throw Exception.InvalidObjectException(String(format: ExceptionMessages.parseBinaryMessageInvalidInput, exception.localizedDescription))
        }
    }
    
    /**
     * Method to extract serialized message from Messages.EncryptedProtocolMessage
     */
    
    func getSerializedMessageEncryptedProtocolMessage(recipientParameters: RecipientParameters?) throws -> Data? {
        
        guard let recipientPrivateKey = recipientParameters?.encryptionParameters?.privateKeyPem else {
            throw Exception.EncryptionException(ExceptionMessages.decryptionMissingRecipientKeysError)
        }
        
        do {
            let protocolMessage = try EncryptedProtocolMessage(serializedData: self)
            
            if let encryptedMessage = protocolMessage.encryptedMessage.toString(), let senderPublicKey = protocolMessage.senderPublicKey.toString() {
                let decryptedMessage = OpenSSLTools().decrypt(encryptedMessage, receiverPrivateKey: recipientPrivateKey, senderPublicKey: senderPublicKey)
                return Data(base64Encoded: decryptedMessage)
            } else {
                throw Exception.InvalidObjectException(ExceptionMessages.encryptionInvalidError)
            }
        } catch let exception {
            throw Exception.InvalidObjectException(String(format: ExceptionMessages.parseBinaryMessageInvalidInput, exception.localizedDescription))
        }
    }
    
    /**
     * Transform binary InvoiceRequest to MessagesInvoiceRequest.
     *
     * @return Messages.InvoiceRequest
     * @throws InvalidObjectException if there is an error parsing the object.
     */
    
    func toMessageInvoiceRequest() throws -> MessageInvoiceRequest? {
        do {
            return try MessageInvoiceRequest(serializedData: self)
        } catch let exception {
            throw Exception.InvalidObjectException(String(format: ExceptionMessages.parseBinaryMessageInvalidInput, exception.localizedDescription))
        }
    }
}
