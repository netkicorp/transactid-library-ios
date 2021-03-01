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
    func toProtocolMessage(messageType: ProtocolMessageType,
                           messageInformation: MessageInformation,
                           senderParameters: SenderParameters? = nil,
                           recipientParameters: RecipientParameters? = nil) -> ProtocolMessage {
        if messageInformation.encryptMessage {
            return self.toProtocolMessageEncrypted(messageType: messageType,
                                                   messageInformation: messageInformation,
                                                   senderParameters: senderParameters,
                                                   recipientParameters: recipientParameters)
        } else {
            return self.toProtocolMessageUnencrypted(messageType: messageType,
                                                     messageInformation: messageInformation)
        }
    }
    

    /**
     * Transform a message in ByteArray to EncryptedProtocolMessage
     */
    func toProtocolMessageEncrypted(messageType: ProtocolMessageType,
                                    messageInformation: MessageInformation,
                                    senderParameters: SenderParameters? = nil,
                                    recipientParameters: RecipientParameters? = nil) -> ProtocolMessage{
        
        var protocolMessage = ProtocolMessage()
        protocolMessage.version = 1
        protocolMessage.statusCode = UInt64(messageInformation.statusCode.rawValue)
        protocolMessage.protocolMessageType = messageType
        protocolMessage.serializedMessage = self
        protocolMessage.statusMessage = messageInformation.statusMessage
        protocolMessage.identifier = CryptoModule().generateIdentifier(message: self)
        return protocolMessage
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
        protocolMessage.identifier = CryptoModule().generateIdentifier(message: self)
        
        return protocolMessage
        
    }
}
