//
//  MessagePaymentRequest.swift
//  transactId-library-ios
//
//  Created by Developer on 06.04.2021.
//

import Foundation
import SwiftProtobuf

struct MessagePaymentRequest {
    
    fileprivate var _paymentDetailsVersion: UInt64? = nil
    fileprivate var _serializedPaymentDetails: Data? = nil
    fileprivate var _beneficiaries: [MessageBeneficiary] = []
    fileprivate var _attestationsRequested: [MessageAttestationType] = []
    fileprivate var _senderPkiType: String? = nil
    fileprivate var _senderPkiData: Data? = nil
    fileprivate var _senderSignature: Data? = nil
    
    
    var paymentDetailsVersion: UInt64 {
        get { return self._paymentDetailsVersion ?? 1 }
        set { self._paymentDetailsVersion = newValue }
    }
    
    var serializedPaymentDetails: Data {
        get { return self._serializedPaymentDetails ?? SwiftProtobuf.Internal.emptyData }
        set { self._serializedPaymentDetails = newValue}
    }
    
    var beneficiaries: [MessageBeneficiary] {
        get { return self._beneficiaries }
    }
    
    mutating func addBeneficiary(messageBeneficiary: MessageBeneficiary) {
        self._beneficiaries.append(messageBeneficiary)
    }
    
    var attestationsRequested: [MessageAttestationType] {
        get { return self._attestationsRequested }
    }
    
    mutating func addAttestationRequested(attestationType: MessageAttestationType) {
        self._attestationsRequested.append(attestationType)
    }
    
    var senderPkiType: String {
        get { return self._senderPkiType ?? "none" }
        set { self._senderPkiType = newValue }
    }
    
    var senderPkiData: Data {
        get { return self._senderPkiData ?? SwiftProtobuf.Internal.emptyData }
        set { self._senderPkiData = newValue }
    }
    
    var senderSignature: Data {
        get { return self._senderSignature ?? SwiftProtobuf.Internal.emptyData }
        set { self._senderSignature = newValue }
    }
    
    var unknownFields = SwiftProtobuf.UnknownStorage()
    
}

extension MessagePaymentRequest : SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
    
    static var protoMessageName: String {
        return "Message.PaymentRequest"
    }
    
    mutating func decodeMessage<D>(decoder: inout D) throws where D : Decoder {
        while let fieldNumber = try decoder.nextFieldNumber() {
            switch fieldNumber {
            case 1: try decoder.decodeSingularUInt64Field(value: &self._paymentDetailsVersion)
            case 2: try decoder.decodeSingularBytesField(value: &self._serializedPaymentDetails)
            case 3: try decoder.decodeRepeatedMessageField(value: &self._beneficiaries)
            case 4: try decoder.decodeRepeatedEnumField(value: &self._attestationsRequested)
            case 5: try decoder.decodeSingularStringField(value: &self._senderPkiType)
            case 6: try decoder.decodeSingularBytesField(value: &self._senderPkiData)
            case 7: try decoder.decodeSingularBytesField(value: &self._senderSignature)
            default: break
            }
        }
    }
    
    func traverse<V>(visitor: inout V) throws where V : Visitor {
        
        if let v = self._paymentDetailsVersion {
            try visitor.visitSingularUInt64Field(value: v, fieldNumber: 1)
        }
        if let v = self._serializedPaymentDetails {
            try visitor.visitSingularBytesField(value: v, fieldNumber: 2)
        }
        if !self._beneficiaries.isEmpty {
            try visitor.visitRepeatedMessageField(value: self._beneficiaries, fieldNumber: 3)
        }
        if !self._attestationsRequested.isEmpty {
            try visitor.visitRepeatedEnumField(value: self._attestationsRequested, fieldNumber: 4)
        }
        if let v = self._senderPkiType {
            try visitor.visitSingularStringField(value: v, fieldNumber: 5)
        }
        if let v = self._senderPkiData {
            try visitor.visitSingularBytesField(value: v, fieldNumber: 6)
        }
        if let v = self._senderSignature {
            try visitor.visitSingularBytesField(value: v, fieldNumber: 7)
        }
        
        try unknownFields.traverse(visitor: &visitor)
    }
    
    
    static var _protobuf_nameMap: _NameMap = [
        1: .same(proto: "payment_details_version"),
        2: .same(proto: "serialized_payment_details"),
        3: .same(proto: "beneficiaries"),
        4: .same(proto: "attestationsRequested"),
        5: .same(proto: "sender_pki_type"),
        6: .same(proto: "sender_pki_data"),
        7: .same(proto: "sender_signature")
    ]
    
    
    func getMessagePkiType() throws -> PkiType {
        if let pkiType = PkiType(rawValue: self.senderPkiType) {
            return pkiType
        } else {
            throw Exception.ObjectNotFoundException("Pki type not supported")
        }
    }
    
    func signMessage(senderParameters: SenderParameters?) throws -> MessagePaymentRequest? {
        let pkiType =  try self.getMessagePkiType()
        switch pkiType {
        case .none:
            return self
        case .x509sha256:
            return self.signWithSender(senderParameters: senderParameters)
        }
        
    }
    
    func signWithSender(senderParameters: SenderParameters?) -> MessagePaymentRequest? {
        do {
            var messagePaymentRequestSigned = MessagePaymentRequest()
            let serializedData = try self.serializedData()
            if let privateKey = senderParameters?.pkiDataParameters?.privateKeyPem {
                if let signature = CryptoModule().sign(privateKeyPem: privateKey, messageData: serializedData) {
                    try messagePaymentRequestSigned.merge(serializedData: serializedData)
                    messagePaymentRequestSigned.senderSignature = signature
                }
            }
            return messagePaymentRequestSigned
            
        } catch let exception {
            print("Require Signature Exception: \(exception)")
            return nil
        }
    }
    
    func removeMessageSenderSignature() throws -> MessagePaymentRequest? {
        let pkiType = try self.getMessagePkiType()
        switch pkiType {
        case .none:
            return self
        case .x509sha256:
            return try self.removeSignature()
        }
    }
    
    private func removeSignature() throws -> MessagePaymentRequest {
        var messagePaymentRequestUnsingned = MessagePaymentRequest()
        let serializedData = try self.serializedData()
        
        try messagePaymentRequestUnsingned.merge(serializedData: serializedData)
        messagePaymentRequestUnsingned.senderSignature = "".toByteString()
        
        return messagePaymentRequestUnsingned
        
    }
    
    func validateMessageSignature(signature: String?) throws -> Bool {
        guard let signature = signature else {
            return false
        }
        let pkiType = try self.getMessagePkiType()
        switch pkiType {
        case .none:
            return true
        case .x509sha256:
            return CryptoModule().validateSignature(signature: signature, data: try self.serializedData().toByteArray(), certificate: self.senderPkiData.toString())
        }
    }
    
    func toPaymentRequest(protocolMessageMetadata: ProtocolMessageMetadata) throws -> PaymentRequest? {
        if let paymentDetails = try self.serializedData().toMessagePaymentDetails() {
            
            var beneficiaries: Array<Beneficiary> = []
            
            self.beneficiaries.forEach({ (messageBeneficiary) in
                beneficiaries.append(messageBeneficiary.toBeneficiary())
            })
            
            var beneficiariesAddresses: Array<Output> = []
            
            paymentDetails.beneficiariesAddresses.forEach({ (messageOutput) in
                beneficiariesAddresses.append(messageOutput.toOutput())
            })
            
            var attestationsRequested: Array<Attestation> = []
            
            self.attestationsRequested.forEach { (messageAttestationType) in
                if let attestation = Attestation(rawValue: messageAttestationType.rawValue) {
                    attestationsRequested.append(attestation)
                }
            }
            
            let paymentRequest = PaymentRequest()
            paymentRequest.paymentDetailsVersion = Int(self.paymentDetailsVersion)
            paymentRequest.network = paymentDetails.network
            paymentRequest.beneficiariesAddresses = beneficiariesAddresses
            paymentRequest.time = TimeInterval(Int(paymentDetails.expires))
            paymentRequest.memo = paymentDetails.memo
            paymentRequest.paymentUrl = paymentDetails.paymentUrl
            paymentRequest.merchantData = paymentDetails.merchantData.toString()
            paymentRequest.beneficiaries = beneficiaries
            paymentRequest.attestationsRequested = attestationsRequested
            paymentRequest.senderPkiType = PkiType(rawValue: self.senderPkiType)
            paymentRequest.senderPkiData = self.senderPkiData.toString()
            paymentRequest.senderSignature = self.senderSignature.toString()
            paymentRequest.protocolMessageMetadata = protocolMessageMetadata
            
            return paymentRequest
            
        }
        
        return nil
    }
    
}
