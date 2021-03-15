//
//  MessageAttestation.swift
//  transactId-library-ios
//
//  Created by Developer on 25.02.2021.
//

import Foundation
import SwiftProtobuf

struct MessageAttestation {
    
    fileprivate var _attestationType: MessageAttestationType? = nil
    fileprivate var _pkiType: String? = nil
    fileprivate var _pkiData: Data? = nil
    fileprivate var _signature: Data? = nil
    
    init() { }
    
    var attestation: MessageAttestationType {
        get { return self._attestationType ?? MessageAttestationType() }
        set { self._attestationType = newValue }
    }
    
    var pkiType: String {
        get { return self._pkiType ?? "none" }
        set { self._pkiType = newValue }
    }
    
    var pkiData: Data {
        get { return self._pkiData ?? SwiftProtobuf.Internal.emptyData }
        set { self._pkiData = newValue }
    }
    
    var signature: Data {
        get { return self._signature ?? SwiftProtobuf.Internal.emptyData }
        set { self._signature = newValue }
    }
    
    var unknownFields = SwiftProtobuf.UnknownStorage()
    
}

extension MessageAttestation : SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
    
    static var protoMessageName: String {
        return "Message.Attestation"
    }
    
    mutating func decodeMessage<D>(decoder: inout D) throws where D : Decoder {
        while let fieldNumber = try decoder.nextFieldNumber() {
            switch fieldNumber {
            case 1: try decoder.decodeSingularEnumField(value: &self._attestationType)
            case 2: try decoder.decodeSingularStringField(value: &self._pkiType)
            case 3: try decoder.decodeSingularBytesField(value: &self._pkiData)
            case 4: try decoder.decodeSingularBytesField(value: &self._signature)
            default: break
            }
        }
    }
    
    func traverse<V>(visitor: inout V) throws where V : Visitor {
        
        if let v = self._attestationType {
            try visitor.visitSingularEnumField(value: v, fieldNumber: 1)
        }
        if let v = self._pkiType {
            try visitor.visitSingularStringField(value: v, fieldNumber: 2)
        }
        if let v = self._pkiData {
            try visitor.visitSingularBytesField(value: v, fieldNumber: 3)
        }
        if let v = self._signature {
            try visitor.visitSingularBytesField(value: v, fieldNumber: 4)
        }
       
        try unknownFields.traverse(visitor: &visitor)
    }
    
    static var _protobuf_nameMap: _NameMap = [
        1: .same(proto: "attestation"),
        2: .standard(proto: "pki_type"),
        3: .standard(proto: "pki_data"),
        4: .same(proto: "signature"),
    ]
}
