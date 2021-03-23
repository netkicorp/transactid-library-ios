//
//  MessageOutput.swift
//  transactId-library-ios
//
//  Created by Developer on 25.02.2021.
//

import Foundation
import SwiftProtobuf

struct MessageOutput {
    fileprivate var _amount: UInt64? = nil
    fileprivate var _script: Data? = nil
    fileprivate var _currency: UInt64? = nil

    init() { }
    
    var amount: UInt64 {
        get { return self._amount ?? 0 }
        set { self._amount = newValue }
    }
    
    var script: Data {
        get { return self._script ?? SwiftProtobuf.Internal.emptyData }
        set { self._script = newValue }
    }
    
    var currency: UInt64 {
        get { return self._currency ?? 0 }
        set { self._currency = newValue }
    }
    
    var unknownFields = SwiftProtobuf.UnknownStorage()
    
}

extension MessageOutput : SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
    
    static var protoMessageName: String {
        return "Message.Output"
    }
    
    mutating func decodeMessage<D>(decoder: inout D) throws where D : Decoder {
        while let fieldNumber = try decoder.nextFieldNumber() {
            switch fieldNumber {
            case 1: try decoder.decodeSingularUInt64Field(value: &self._amount)
            case 2: try decoder.decodeSingularBytesField(value: &self._script)
            case 3: try decoder.decodeSingularUInt64Field(value: &self._currency)
            default: break
            }
        }
    }
    
    func traverse<V>(visitor: inout V) throws where V : Visitor {
        
        if let v = self._amount {
            try visitor.visitSingularUInt64Field(value: v, fieldNumber: 1)
        }
        if let v = self._script {
            try visitor.visitSingularBytesField(value: v, fieldNumber: 2)
        }
        if let v = self._currency {
            try visitor.visitSingularUInt64Field(value: v, fieldNumber: 3)
        }
       
        try unknownFields.traverse(visitor: &visitor)
    }
    
    static var _protobuf_nameMap: _NameMap = [
        1: .same(proto: "amount"),
        2: .standard(proto: "script"),
        3: .standard(proto: "currency"),
    ]
    
    func toOutput() -> Output {
        return Output(amount: Int(self.amount),
                      script: self.script.toString(),
                      currency: AddressCurrency(rawValue: Int(self.currency)) ?? .bitcoin)
    }
}
