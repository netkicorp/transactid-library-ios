//
//  MessagePaymentACK.swift
//  transactId-library-ios
//
//  Created by Developer on 15.04.2021.
//

import Foundation
import SwiftProtobuf

struct MessagePaymentACK {
    
    fileprivate var _payment: MessagePayment? = nil
    fileprivate var _memo: String? = nil
    
    var payment: MessagePayment {
        get { return self._payment ?? MessagePayment() }
        set { self._payment = newValue }
    }
    
    var memo: String {
        get { return self._memo ?? String() }
        set { self._memo = newValue }
    }
    
    var unknownFields = SwiftProtobuf.UnknownStorage()
    
}

extension MessagePaymentACK : SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
    
    static var protoMessageName: String {
        return "Message.PaymentACK"
    }
    
    mutating func decodeMessage<D>(decoder: inout D) throws where D : Decoder {
        while let fieldNumber = try decoder.nextFieldNumber() {
            switch fieldNumber {
            case 1: try decoder.decodeSingularMessageField(value: &self._payment)
            case 2: try decoder.decodeSingularStringField(value: &self._memo)
            default: break
            }
        }
    }
    
    func traverse<V>(visitor: inout V) throws where V : Visitor {

        if let v = self._payment {
            try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
        }
        if let v = self._memo {
            try visitor.visitSingularStringField(value: v, fieldNumber: 2)
        }
        
        try unknownFields.traverse(visitor: &visitor)
    }
    
    static var _protobuf_nameMap: _NameMap = [
        1: .same(proto: "payment"),
        2: .same(proto: "memo")
    ]
    
    /**
     * Transform MessagePaymentACK to PaymentACK object.
     *
     * @return PaymentACK.
     */
    func toPaymentACK(protocolMessageMetadata: ProtocolMessageMetadata? = nil) throws -> PaymentACK? {
        let paymentACK = PaymentACK()
        paymentACK.payment = try self.payment.toPayment()
        paymentACK.memo = self.memo
        paymentACK.protocolMessageMetadata = protocolMessageMetadata
        return paymentACK
    }
}
