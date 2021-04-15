//
//  MessagePayment.swift
//  transactId-library-ios
//
//  Created by Developer on 12.04.2021.
//

import Foundation
import SwiftProtobuf

struct MessagePayment {
    
    fileprivate var _merchantData: Data? = nil
    fileprivate var _transactions: Array<Data> = []
    fileprivate var _refundTo: Array<MessageOutput> = []
    fileprivate var _memo: String? = nil
    fileprivate var _originators: Array<MessageOriginator> = []
    fileprivate var _beneficiaries: Array<MessageBeneficiary> = []

    
    var merchantData: Data {
        get { return self._merchantData ?? SwiftProtobuf.Internal.emptyData }
        set { self._merchantData = newValue}
    }
    
    var transactions: Array<Data> {
        get { return self._transactions }
    }
    
    mutating func addTransaction(transaction: Data) {
        self._transactions.append(transaction)
    }
    
    var refundTo: Array<MessageOutput> {
        get { return self._refundTo }
    }
    
    mutating func addRefund(messageOutput: MessageOutput) {
        self._refundTo.append(messageOutput)
    }
    
    var memo: String {
        get { return self._memo ?? String() }
        set { self._memo = newValue }
    }
    
    var originators: Array<MessageOriginator> {
        get { return self._originators }
    }
    
    mutating func addOriginator(messageOriginator: MessageOriginator) {
        self._originators.append(messageOriginator)
    }
    
    var beneficiaries: Array<MessageBeneficiary> {
        get { return self._beneficiaries }
    }
    
    mutating func addBeneficiary(messageBeneficiary: MessageBeneficiary) {
        self._beneficiaries.append(messageBeneficiary)
    }
    
    var unknownFields = SwiftProtobuf.UnknownStorage()
    
}

extension MessagePayment : SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
    
    static var protoMessageName: String {
        return "Message.Payment"
    }
    
    mutating func decodeMessage<D>(decoder: inout D) throws where D : Decoder {
        while let fieldNumber = try decoder.nextFieldNumber() {
            switch fieldNumber {
            case 1: try decoder.decodeSingularBytesField(value: &self._merchantData)
            case 2: try decoder.decodeRepeatedBytesField(value: &self._transactions)
            case 3: try decoder.decodeRepeatedMessageField(value: &self._refundTo)
            case 4: try decoder.decodeSingularStringField(value: &self._memo)
            case 5: try decoder.decodeRepeatedMessageField(value: &self._originators)
            case 6: try decoder.decodeRepeatedMessageField(value: &self._beneficiaries)
            default: break
            }
        }
    }
    
    func traverse<V>(visitor: inout V) throws where V : Visitor {
        
        if let v = self._merchantData {
            try visitor.visitSingularBytesField(value: v, fieldNumber: 1)
        }
        if !self._transactions.isEmpty {
            try visitor.visitRepeatedBytesField(value: self._transactions, fieldNumber: 2)
        }
        if !self._refundTo.isEmpty {
            try visitor.visitRepeatedMessageField(value: self._refundTo, fieldNumber: 3)
        }
        if let v = self._memo {
            try visitor.visitSingularStringField(value: v, fieldNumber: 4)
        }
        if !self._originators.isEmpty {
            try visitor.visitRepeatedMessageField(value: self._originators, fieldNumber: 5)
        }
        if !self._beneficiaries.isEmpty {
            try visitor.visitRepeatedMessageField(value: self._beneficiaries, fieldNumber: 6)
        }
        
        try unknownFields.traverse(visitor: &visitor)
    }
    
    static var _protobuf_nameMap: _NameMap = [
        1: .same(proto: "merchant_data"),
        2: .same(proto: "transactions"),
        3: .same(proto: "refund_to"),
        4: .same(proto: "memo"),
        5: .same(proto: "originators"),
        6: .same(proto: "beneficiaries")
    ]
    
    /**
     * Transform MessagePayment to Payment object.
     *
     * @return Payment.
     */
    func toPayment(protocolMessageMetadata: ProtocolMessageMetadata? = nil) throws -> Payment? {
        
        var transactions: Array<Data> = []
        self.transactions.forEach { (transaction) in
            transactions.append(transaction)
        }
        
        var outputs: Array<Output> = []
        self.refundTo.forEach { (messageOutput) in
            outputs.append(messageOutput.toOutput())
        }
        
        var beneficiaries: Array<Beneficiary> = []
        self.beneficiaries.forEach { (messageBeneficiary) in
            beneficiaries.append(messageBeneficiary.toBeneficiary())
        }
        
        var originators: Array<Originator> = []

        self.originators.forEach { (messageOriginator) in
            originators.append(messageOriginator.toOriginator())
        }
        
        let payment = Payment()
        payment.merchantData = self.merchantData.toString()
        payment.transactions = transactions
        payment.outputs = outputs
        payment.memo = self.memo
        payment.beneficiaries = beneficiaries
        payment.originators = originators
        payment.protocolMessageMetadata = protocolMessageMetadata
        
        return payment
    }
}


