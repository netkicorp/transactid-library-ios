//
//  ProtocolMessage.swift
//  transactId-library-ios
//
//  Created by Developer on 01.03.2021.
//

import Foundation
import SwiftProtobuf

struct ProtocolMessage {
    
    fileprivate var _version: UInt64? = nil
    fileprivate var _statusCode: UInt64? = nil
    fileprivate var _protocolMessageType: ProtocolMessageType? = nil
    fileprivate var _serializedMessage: Data? = nil
    fileprivate var _statusMessage: String? = nil
    fileprivate var _identifier: Data? = nil
    
    init() { }
    
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
    
    var serializedMessage: Data {
        get { return self._serializedMessage ?? SwiftProtobuf.Internal.emptyData }
        set { self._serializedMessage = newValue }
    }
    
    var statusMessage: String {
        get { return self._statusMessage ?? String() }
        set { self._statusMessage = newValue }
    }
    
    var identifier: Data {
        get { return self._identifier ?? SwiftProtobuf.Internal.emptyData }
        set { self._identifier = newValue }
    }
    
    var unknownFields = SwiftProtobuf.UnknownStorage()
}

extension ProtocolMessage: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
    
    static var protoMessageName: String {
        return "Message.ProtocolMessage"
    }
    
    mutating func decodeMessage<D>(decoder: inout D) throws where D : Decoder {
        while let fieldNumber = try decoder.nextFieldNumber() {
            switch fieldNumber {
            case 1: try decoder.decodeSingularUInt64Field(value: &self._version)
            case 2: try decoder.decodeSingularUInt64Field(value: &self._statusCode)
            case 3: try decoder.decodeSingularEnumField(value: &self._protocolMessageType)
            case 4: try decoder.decodeSingularBytesField(value: &self._serializedMessage)
            case 5: try decoder.decodeSingularStringField(value: &self._statusMessage)
            case 6: try decoder.decodeSingularBytesField(value: &self._identifier)
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
        if let v = self._serializedMessage {
            try visitor.visitSingularBytesField(value: v, fieldNumber: 4)
        }
        if let v = self._statusMessage {
            try visitor.visitSingularStringField(value: v, fieldNumber: 5)
        }
        if let v = self._identifier {
            try visitor.visitSingularBytesField(value: v, fieldNumber: 6)
        }
        
        try unknownFields.traverse(visitor: &visitor)
    }
    
    static var _protobuf_nameMap: _NameMap = [
        1: .standard(proto: "version"),
        2: .standard(proto: "status_code"),
        3: .same(proto: "message_type"),
        4: .same(proto: "serialized_message"),
        5: .same(proto: "status_message"),
        6: .same(proto: "identifier")
    ]
}
