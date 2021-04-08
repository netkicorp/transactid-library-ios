//
//  MessagePaymentDetails.swift
//  transactId-library-ios
//
//  Created by Developer on 06.04.2021.
//

import Foundation
import SwiftProtobuf

struct MessagePaymentDetails {
    
    fileprivate var _network: String? = nil
    fileprivate var _beneficiariesAddresses: [MessageOutput] = []
    fileprivate var _time: UInt64? = nil
    fileprivate var _expires: UInt64? = nil
    fileprivate var _memo: String? = nil
    fileprivate var _paymentUrl: String? = nil
    fileprivate var _merchantData: Data? = nil

    init() { }
    
    var network: String {
        get { return self._network ?? "main" }      // "main" or "test"
        set { self._network = newValue }
    }
    
    var beneficiariesAddresses: [MessageOutput] {
        get { return self._beneficiariesAddresses }
    }
    
    mutating func addBeneficiariesAddresses(beneficiariesAddress: MessageOutput) {
        self._beneficiariesAddresses.append(beneficiariesAddress)
    }
    
    var time: UInt64 {
        get { return self._time ?? 0 }
        set { self._time = newValue }
    }
    
    var expires: UInt64 {
        get { return self._expires ?? 0 }
        set { self._expires = newValue }
    }
    
    var memo: String {
        get { return self._memo ?? "" }
        set { self._memo = newValue }
    }
    
    var paymentUrl: String {
        get { return self._paymentUrl ?? "" }
        set { self._paymentUrl = newValue }
    }
    
    var merchantData: Data {
        get { return self._merchantData ?? SwiftProtobuf.Internal.emptyData }
        set { self._merchantData = newValue}
    }
    
    var unknownFields = SwiftProtobuf.UnknownStorage()
}

extension MessagePaymentDetails : SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
    
    static var protoMessageName: String {
        return "Message.PaymentDetails"
    }
    
    mutating func decodeMessage<D>(decoder: inout D) throws where D : Decoder {
        while let fieldNumber = try decoder.nextFieldNumber() {
            switch fieldNumber {
            case 1: try decoder.decodeSingularStringField(value: &self._network)
            case 2: try decoder.decodeRepeatedMessageField(value: &self._beneficiariesAddresses)
            case 3: try decoder.decodeSingularUInt64Field(value: &self._time)
            case 4: try decoder.decodeSingularUInt64Field(value: &self._expires)
            case 5: try decoder.decodeSingularStringField(value: &self._memo)
            case 6: try decoder.decodeSingularStringField(value: &self._paymentUrl)
            case 7: try decoder.decodeSingularBytesField(value: &self._merchantData)
            default: break
            }
        }
    }
    
    func traverse<V>(visitor: inout V) throws where V : Visitor {
        if let v = self._network {
            try visitor.visitSingularStringField(value: v, fieldNumber: 1)
        }
        if !self._beneficiariesAddresses.isEmpty {
            try visitor.visitRepeatedMessageField(value: self._beneficiariesAddresses, fieldNumber: 2)
        }
        if let v = self._time {
            try visitor.visitSingularUInt64Field(value: v, fieldNumber: 3)
        }
        if let v = self._expires {
            try visitor.visitSingularUInt64Field(value: v, fieldNumber: 4)
        }
        if let v = self._memo {
            try visitor.visitSingularStringField(value: v, fieldNumber: 5)
        }
        if let v = self._paymentUrl {
            try visitor.visitSingularStringField(value: v, fieldNumber: 6)
        }
        if let v = self._merchantData {
            try visitor.visitSingularBytesField(value: v, fieldNumber: 7)
        }
        
        try unknownFields.traverse(visitor: &visitor)
    }
    
    static var _protobuf_nameMap: _NameMap = [
        1: .same(proto: "network"),
        2: .same(proto: "beneficiariesAddresses"),
        3: .same(proto: "time"),
        4: .same(proto: "expires"),
        5: .same(proto: "memo"),
        6: .same(proto: "payment_url"),
        7: .same(proto: "merchant_data")
    ]
    
    
    /**
     * Transform MessagePaymentDetails to MessagePaymentRequest
     *
     * @param senderParameters the sender of the message.
     * @param paymentParametersVersion
     * @return MessagePaymentRequest
     */
    func toPaymentRequest(senderParameters: SenderParameters,
                          paymentParametersVersion: Int,
                          attestationsRequested: Array<Attestation>) throws -> MessagePaymentRequest {
        
        var messagePaymentRequest: MessagePaymentRequest  = MessagePaymentRequest()
        messagePaymentRequest.paymentDetailsVersion = UInt64(paymentParametersVersion)
        messagePaymentRequest.serializedPaymentDetails = try self.serializedData()
        
        if let senderPkiDataParameters = senderParameters.pkiDataParameters {
            messagePaymentRequest.senderPkiType = senderPkiDataParameters.type.rawValue
            if let certificatePem = senderPkiDataParameters.certificatePem {
                messagePaymentRequest.senderPkiData = certificatePem.toByteString()
            }
        }
        messagePaymentRequest.senderSignature = "".toByteString()
        
        attestationsRequested.forEach { (attestation) in
            messagePaymentRequest.addAttestationRequested(attestationType: MessageAttestationType(rawValue: attestation.rawValue) ?? MessageAttestationType())
        }
        
        return messagePaymentRequest
    }
}
