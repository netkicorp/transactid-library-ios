//
//  MessageBeneficiary.swift
//  transactId-library-ios
//
//  Created by Developer on 25.02.2021.
//

import Foundation
import SwiftProtobuf

struct MessageBeneficiary {
    
    fileprivate var _isPrimaryForTransaction: Bool? = nil
    fileprivate var _attestations: [MessageAttestation] = []
    
    init() { }
    
    var isPrimaryForTransaction: Bool {
        get { return self._isPrimaryForTransaction ?? false }
        set { self._isPrimaryForTransaction = newValue }
    }
    
    var attestations : [MessageAttestation] {
        get { return self._attestations}
    }
    
    mutating func addAttestation(attestation: MessageAttestation) {
        self._attestations.append(attestation)
    }
    
    var unknownFields = SwiftProtobuf.UnknownStorage()
}

extension MessageBeneficiary : SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
    
    static var protoMessageName: String {
        return "Message.Beneficiary"
    }
    
    mutating func decodeMessage<D>(decoder: inout D) throws where D : Decoder {
        while let fieldNumber = try decoder.nextFieldNumber() {
          switch fieldNumber {
          case 1: try decoder.decodeSingularBoolField(value: &self._isPrimaryForTransaction)
          case 2: try decoder.decodeRepeatedMessageField(value: &self._attestations)
          default: break
          }
        }
    }
    
    func traverse<V>(visitor: inout V) throws where V : Visitor {
        if let v = self._isPrimaryForTransaction {
          try visitor.visitSingularBoolField(value: v, fieldNumber: 1)
        }
        if !self._attestations.isEmpty {
            try visitor.visitRepeatedMessageField(value: self._attestations, fieldNumber: 2)
        }
        try unknownFields.traverse(visitor: &visitor)
    }
    
    static var _protobuf_nameMap: _NameMap = [
        1: .same(proto: "primary_for_transaction"),
        2: .same(proto: "attestations")
    ]
}

