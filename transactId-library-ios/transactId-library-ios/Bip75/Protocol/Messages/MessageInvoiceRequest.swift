//
//  MessageInvoiceRequest.swift
//  transactId-library-ios
//
//  Created by Developer on 25.02.2021.
//

import Foundation
import SwiftProtobuf

struct MessageInvoiceRequest {
    
    fileprivate var _amount: UInt64? = nil
    fileprivate var _pkiType: String? = nil
    fileprivate var _pkiData: Data? = nil
    fileprivate var _memo: String? = nil
    fileprivate var _notificationURL: String? = nil
    fileprivate var _signature: Data? = nil
    fileprivate var _evCert: Data? = nil
    fileprivate var _beneficiaries: [MessageBeneficiary] = []
    fileprivate var _outputs: [MessageOutput] = []
    fileprivate var _attestations: [MessageAttestationType] = []
    fileprivate var _recipientChainAddress: String? = nil
    fileprivate var _recipientVaspName: String? = nil
    fileprivate var _originators: [MessageOriginator] = []
    
    init() { }
    
    var amount: UInt64 {
        get { return self._amount ?? 0 }
        set { self._amount = newValue }
    }
    
    var pkiType: String {
        get { return self._pkiType ?? "none" }
        set { self._pkiType = newValue }
    }
    
    var pkiData: Data {
        get { return self._pkiData ?? SwiftProtobuf.Internal.emptyData }
        set { self._pkiData = newValue }
    }
    
    var memo: String {
        get { return self._memo ?? String() }
        set { self._memo = newValue }
    }
    
    var notificationURL: String {
        get { return self._notificationURL ?? String() }
        set { self._notificationURL = newValue }
    }
    
    var signature: Data {
        get { return self._signature ?? SwiftProtobuf.Internal.emptyData }
        set { self._signature = newValue }
    }
    
    var evCert: Data {
        get { return self._evCert ?? SwiftProtobuf.Internal.emptyData }
        set { self._evCert = newValue }
    }
    
    var beneficiaries: [MessageBeneficiary] {
        get { return self._beneficiaries }
    }
    
    mutating func addBeneficiary(messageBeneficiary: MessageBeneficiary) {
        self._beneficiaries.append(messageBeneficiary)
    }
    
    var originators: [MessageOriginator] {
        get { return self._originators }
    }
    
    mutating func addOriginator(messageOriginator: MessageOriginator) {
        self._originators.append(messageOriginator)
    }
    
    var outputs: [MessageOutput] {
        get { return self._outputs }
    }
    
    mutating func addOutput(output: MessageOutput) {
        self._outputs.append(output)
    }
    
    var attestations: [MessageAttestationType] {
        get { return self._attestations }
    }
    
    mutating func addAttestation(attestationType: MessageAttestationType) {
        self._attestations.append(attestationType)
    }
        
    var recipientChainAddress: String {
        get { return self._recipientChainAddress ?? String() }
        set { self._recipientChainAddress = newValue }
    }
    
    var recipientVaspName: String {
        get { return self._recipientVaspName ?? String() }
        set { self._recipientVaspName = newValue }
    }
    
    var unknownFields = SwiftProtobuf.UnknownStorage()
    
}

extension MessageInvoiceRequest : SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
    
    static var protoMessageName: String {
        return "Message.InvoiceRequest"
    }
    
    mutating func decodeMessage<D>(decoder: inout D) throws where D : Decoder {
        while let fieldNumber = try decoder.nextFieldNumber() {
            switch fieldNumber {
            case 1: try decoder.decodeSingularUInt64Field(value: &self._amount)
            case 2: try decoder.decodeSingularStringField(value: &self._memo)
            case 3: try decoder.decodeSingularStringField(value: &self._notificationURL)
            case 4: try decoder.decodeRepeatedMessageField(value: &self._originators)
            case 5: try decoder.decodeRepeatedMessageField(value: &self._beneficiaries)
            case 6: try decoder.decodeRepeatedMessageField(value: &self._outputs)
            case 7: try decoder.decodeRepeatedEnumField(value: &self._attestations)
            case 8: try decoder.decodeSingularStringField(value: &self._pkiType)
            case 9: try decoder.decodeSingularBytesField(value: &self._pkiData)
            case 10: try decoder.decodeSingularBytesField(value: &self._signature)
            case 11: try decoder.decodeSingularBytesField(value: &self._evCert)
            case 12: try decoder.decodeSingularStringField(value: &self._recipientVaspName)
            case 13: try decoder.decodeSingularStringField(value: &self._recipientChainAddress)
            default: break
            }
        }
    }
    
    func traverse<V>(visitor: inout V) throws where V : Visitor {
        
        if let v = self._amount {
            try visitor.visitSingularUInt64Field(value: v, fieldNumber: 1)
        }
        if let v = self._memo {
            try visitor.visitSingularStringField(value: v, fieldNumber: 2)
        }
        if let v = self._notificationURL {
            try visitor.visitSingularStringField(value: v, fieldNumber: 3)
        }
        if !self._originators.isEmpty {
            try visitor.visitRepeatedMessageField(value: self._originators, fieldNumber: 4)
        }
        if !self._beneficiaries.isEmpty {
            try visitor.visitRepeatedMessageField(value: self._beneficiaries, fieldNumber: 5)
        }
        if !self._outputs.isEmpty {
            try visitor.visitRepeatedMessageField(value: self._outputs, fieldNumber: 6)
        }
        if !self._attestations.isEmpty {
            try visitor.visitRepeatedEnumField(value: self._attestations, fieldNumber: 7)
        }
        if let v = self._pkiType {
            try visitor.visitSingularStringField(value: v, fieldNumber: 8)
        }
        if let v = self._pkiData {
            try visitor.visitSingularBytesField(value: v, fieldNumber: 9)
        }
        if let v = self._signature {
            try visitor.visitSingularBytesField(value: v, fieldNumber: 10)
        }
        if let v = self._evCert {
            try visitor.visitSingularBytesField(value: v, fieldNumber: 11)
        }
        if let v = self._recipientVaspName {
            try visitor.visitSingularStringField(value: v, fieldNumber: 12)
        }
        if let v = self._recipientChainAddress {
            try visitor.visitSingularStringField(value: v, fieldNumber: 13)
        }
        
       
        try unknownFields.traverse(visitor: &visitor)
    }
    
    static var _protobuf_nameMap: _NameMap = [
        1: .same(proto: "amount"),
        2: .same(proto: "memo"),
        3: .standard(proto: "notification_url"),
        4: .same(proto: "originators"),
        5: .same(proto: "beneficiaries"),
        6: .same(proto: "originatorsAddresses"),
        7: .same(proto: "attestationsRequested"),
        8: .standard(proto: "sender_pki_type"),
        9: .standard(proto: "sender_pki_data"),
        10: .same(proto: "signature"),
        11: .same(proto: "sender_ev_cert"),
        12: .same(proto: "recipient_vasp_name"),
        13: .same(proto: "recipient_chain_address")
    ]
    
    func getMessagePkiType() throws -> PkiType {
        if let pkiType = PkiType(rawValue: self.pkiType) {
            return pkiType
        } else {
            throw Exception.ObjectNotFoundException("Pki type not supported")
        }
    }
    
    func signMessage(senderParameters: SenderParameters?) throws -> MessageInvoiceRequest? {
        let pkiType =  try self.getMessagePkiType()
        switch pkiType {
        case .none:
            return self
        case .x509sha256:
            return self.signWithSender(senderParameters: senderParameters)
        }
        
    }
    
    func signWithSender(senderParameters: SenderParameters?) -> MessageInvoiceRequest? {
        do {
            var messageInvoiceRequestSigned = MessageInvoiceRequest()
            let serializedData = try self.serializedData()
            if let privateKey = senderParameters?.pkiDataParameters?.privateKeyPem {
                if let signature = CryptoModule().sign(privateKeyPem: privateKey, messageData: serializedData) {
                    try messageInvoiceRequestSigned.merge(serializedData: serializedData)
                    messageInvoiceRequestSigned.signature = signature
                }
            }
            return messageInvoiceRequestSigned
            
        } catch let exception {
            print("Require Signature Exception: \(exception)")
            return nil
        }
    }
    
    func toInvoiceRequest(protocolMessageMetadata: ProtocolMessageMetadata) -> InvoiceRequest {
        
        var beneficiaries: Array<Beneficiary> = []
        
        self.beneficiaries.forEach({ (messageBeneficiary) in
            beneficiaries.append(messageBeneficiary.toBeneficiary())
        })
        
        var originators: Array<Originator> = []
        
        self.originators.forEach { (messageOriginator) in
            originators.append(messageOriginator.toOriginator())
        }
        
        var originatorsAddresses: Array<Output> = []
        
        self.outputs.forEach { (messageOutput) in
            originatorsAddresses.append(messageOutput.toOutput())
        }

        var attestationsRequested: Array<Attestation> = []
        
        self.attestations.forEach { (messageAttestationType) in
            if let attestation = Attestation(rawValue: messageAttestationType.rawValue) {
                attestationsRequested.append(attestation)
            }
        }
        
        let invoiceRequest = InvoiceRequest()
        
        invoiceRequest.amount = Int(self.amount)
        invoiceRequest.memo = self.memo
        invoiceRequest.notificationUrl = self.notificationURL
        invoiceRequest.originators = originators
        invoiceRequest.beneficiaries = beneficiaries
        invoiceRequest.originatorsAddresses = originatorsAddresses
        invoiceRequest.attestationsRequested = attestationsRequested
        invoiceRequest.senderPkiType = PkiType(rawValue: self.pkiType)
        invoiceRequest.senderPkiData = self.pkiData.toString()
        invoiceRequest.senderSignature = self.signature.toString()
        invoiceRequest.senderEvCert = self.evCert.toString()
        invoiceRequest.recipientVaspName = self.recipientVaspName
        invoiceRequest.recipientChainAddress = self.recipientChainAddress
        invoiceRequest.protocolMessageMetadata = protocolMessageMetadata
        
        return invoiceRequest
    }
    
    func removeMessageSenderSignature() throws -> MessageInvoiceRequest? {
        let pkiType = try self.getMessagePkiType()
        switch pkiType {
        case .none:
            return self
        case .x509sha256:
            return try self.removeSenderSignature()
        }
    }
    
    private func removeSenderSignature() throws -> MessageInvoiceRequest {
        var messageInvoiceRequestUnsingned = MessageInvoiceRequest()
        let serializedData = try self.serializedData()
        
        try messageInvoiceRequestUnsingned.merge(serializedData: serializedData)
        messageInvoiceRequestUnsingned.signature = "".toByteString()
        
        return messageInvoiceRequestUnsingned
        
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
            return CryptoModule().validateSignature(signature: signature, data: try self.serializedData().toByteArray(), certificate: self.pkiData.toString())
        }
    }
}

