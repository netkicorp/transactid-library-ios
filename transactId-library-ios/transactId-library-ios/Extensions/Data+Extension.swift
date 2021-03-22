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
}
