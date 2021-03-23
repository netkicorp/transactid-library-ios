//
//  EncryptedProtocolMessage.swift
//  transactId-library-ios
//
//  Created by Developer on 03.03.2021.
//

import Foundation
import SwiftProtobuf

struct EncryptedProtocolMessage : SwiftProtobuf.Message {
    
    fileprivate var _version: UInt64? = nil
    fileprivate var _statusCode: UInt64? = nil
    fileprivate var _protocolMessageType: ProtocolMessageType? = nil
    fileprivate var _encryptedMessage: Data? = nil
    fileprivate var _receiverPublicKey: Data? = nil
    fileprivate var _senderPublicKey: Data? = nil
    fileprivate var _nonce : UInt64? = nil
    fileprivate var _identifier: Data? = nil
    fileprivate var _statusMessage: String? = nil
    fileprivate var _signature: Data? = nil

    init() { }
    
    var isInitialized: Bool {
        return self._version != nil &&
            self._statusCode != nil &&
            self._protocolMessageType != nil &&
            self._encryptedMessage != nil &&
            self._nonce != nil &&
            self._identifier != nil &&
            self._receiverPublicKey != nil &&
            self._senderPublicKey != nil
    }
    
    var version: UInt64 {
        get { return self._version ?? 1}
        set { self._version = newValue }
    }
    
    var statusCode: UInt64 {
        get { return self._statusCode ?? 1}
        set { self._statusCode = newValue }
    }
    
    var protocolMessageType: ProtocolMessageType {
        get { return self._protocolMessageType ?? ProtocolMessageType() }
        set { self._protocolMessageType = newValue }
    }
    
    var encryptedMessage: Data {
        get { return self._encryptedMessage ?? Data() }
        set { self._encryptedMessage = newValue }
    }
    
    var receiverPublicKey: Data {
        get { return self._receiverPublicKey ?? Data() }
        set { self._receiverPublicKey = newValue }
    }
    
    var senderPublicKey: Data {
        get { return self._senderPublicKey ?? Data() }
        set { self._senderPublicKey = newValue }
    }
    
    var nonce: UInt64 {
        get { return self._nonce ?? 1}
        set { self._nonce = newValue }
    }
    
    var identifier: Data {
        get { return self._identifier ?? SwiftProtobuf.Internal.emptyData }
        set { self._identifier = newValue }
    }
    
    var statusMessage: String {
        get { return self._statusMessage ?? String() }
        set { self._statusMessage = newValue }
    }
    
    var signature: Data {
        get { return self._signature ?? SwiftProtobuf.Internal.emptyData }
        set { self._signature = newValue }
    }
    
    var unknownFields = SwiftProtobuf.UnknownStorage()
    
}

extension EncryptedProtocolMessage :  SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
    
    static var protoMessageName: String {
        return "Message.EncryptedProtocolMessage"
    }
    
    mutating func decodeMessage<D>(decoder: inout D) throws where D : Decoder {
        while let fieldNumber = try decoder.nextFieldNumber() {
            switch fieldNumber {
            case 1: try decoder.decodeSingularUInt64Field(value: &self._version)
            case 2: try decoder.decodeSingularUInt64Field(value: &self._statusCode)
            case 3: try decoder.decodeSingularEnumField(value: &self._protocolMessageType)
            case 4: try decoder.decodeSingularBytesField(value: &self._encryptedMessage)
            case 5: try decoder.decodeSingularBytesField(value: &self._receiverPublicKey)
            case 6: try decoder.decodeSingularBytesField(value: &self._senderPublicKey)
            case 7: try decoder.decodeSingularUInt64Field(value: &self._nonce)
            case 8: try decoder.decodeSingularBytesField(value: &self._identifier)
            case 9: try decoder.decodeSingularStringField(value: &self._statusMessage)
            case 10: try decoder.decodeSingularBytesField(value: &self._signature)
            default: break
            }
        }
    }
    
    func traverse<V>(visitor: inout V) throws where V : Visitor {
        
        if let v = self._version {
            try visitor.visitSingularUInt64Field(value: v, fieldNumber: 1)
        }
        if let v = self._statusCode {
            try visitor.visitSingularUInt64Field(value: v, fieldNumber: 2)
        }
        if let v = self._protocolMessageType {
            try visitor.visitSingularEnumField(value: v, fieldNumber: 3)
        }
        if let v = self._encryptedMessage {
            try visitor.visitSingularBytesField(value: v, fieldNumber: 4)
        }
        if let v = self._receiverPublicKey {
            try visitor.visitSingularBytesField(value: v, fieldNumber: 5)
        }
        if let v = self._senderPublicKey {
            try visitor.visitSingularBytesField(value: v, fieldNumber: 6)
        }
        if let v = self._nonce {
            try visitor.visitSingularUInt64Field(value: v, fieldNumber: 7)
        }
        if let v = self._identifier {
            try visitor.visitSingularBytesField(value: v, fieldNumber: 8)
        }
        if let v = self._statusMessage {
            try visitor.visitSingularStringField(value: v, fieldNumber: 9)
        }
        if let v = self._signature {
            try visitor.visitSingularBytesField(value: v, fieldNumber: 10)
        }
        
        try unknownFields.traverse(visitor: &visitor)
    }
    
    static var _protobuf_nameMap: _NameMap = [
        1: .standard(proto: "version"),
        2: .standard(proto: "status_code"),
        3: .same(proto: "message_type"),
        4: .same(proto: "encrypted_message"),
        5: .same(proto: "receiver_public_key"),
        6: .same(proto: "sender_public_key"),
        7: .same(proto: "nonce"),
        8: .same(proto: "identifier"),
        9: .same(proto: "status_message"),
        10: .same(proto: "signature"),
    ]
}
