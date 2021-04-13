//
//  Bip75ServiceNetki.swift
//  transactId-library-ios
//
//  Created by Developer on 09.02.2021.
//

import Foundation

class Bip75ServiceNetki: Bip75Service {
    
    private let certificateValidator: CertificateValidator
    private let addressInformationService: AddressInformationService?
    
    init(certificateValidator: CertificateValidator, addressInformationService: AddressInformationService? = nil) {
        self.certificateValidator = certificateValidator
        self.addressInformationService = addressInformationService
    }
    
    
    //MARK: InvoiceRequest
    
    func createInvoiceRequest(invoiceRequestParameters: InvoiceRequestParameters) throws -> Data? {
        
        try invoiceRequestParameters.originatorParameters?.validate(required: true, ownerType: .originator)
        try invoiceRequestParameters.beneficiaryParameters?.validate(required: false, ownerType: .beneficiary)
        
        var messageInvoiceRequest = invoiceRequestParameters.toMessageInvoiceRequestUnsigned()
        
        invoiceRequestParameters.beneficiaryParameters?.forEach({ (beneficiary) in
            var messageBeneficiary = beneficiary.toMessageBeneficiaryWithoutAttestations()
            beneficiary.pkiDataParametersSets?.forEach({ (pkiData) in
                let attestation = pkiData.toMessageAttestation(requireSignature: false)
                messageBeneficiary.addAttestation(attestation: attestation)
            })
            messageInvoiceRequest.addBeneficiary(messageBeneficiary: messageBeneficiary)
        })
        
        invoiceRequestParameters.originatorParameters?.forEach({ (originator) in
            var messageOriginator = originator.toMessageOriginatorWithoutAttestations()
            
            originator.pkiDataParametersSets?.forEach({ (pkiData) in
                let attestation = pkiData.toMessageAttestation(requireSignature: originator.isPrimaryForTransaction)
                
                messageOriginator.addAttestation(attestation: attestation)
            })
            messageInvoiceRequest.addOriginator(messageOriginator: messageOriginator)
        })
        
        let invoiceRequest = try messageInvoiceRequest.signMessage(senderParameters: invoiceRequestParameters.senderParameters)?.serializedData()
        
        return try invoiceRequest?.toProtocolMessageData(messageType: .invoiceRequest,
                                                         messageInformation: invoiceRequestParameters.messageInformation,
                                                         senderParameters: invoiceRequestParameters.senderParameters,
                                                         recipientParameters: invoiceRequestParameters.recipientParameters)
    }
    
    func isInvoiceRequestValid(invoiceRequestBinary: Data, recipientParameters: RecipientParameters?) throws -> Bool {
        if let protocolMessageMetadata = try invoiceRequestBinary.extractProtocolMessageMetadata() {
            if let messageInvoiceRequestData = try invoiceRequestBinary.getSerializedMessage(encrypted: protocolMessageMetadata.encrypted, recipientParameters: recipientParameters) {
                if let messageInvoiceRequest = try messageInvoiceRequestData.toMessageInvoiceRequest() {
                    
                    if (protocolMessageMetadata.encrypted) {
                        let isSenderEncryptionSignatureValid =  try invoiceRequestBinary.validateMessageEncryptionSignature()
                        if (!isSenderEncryptionSignatureValid) {
                            throw Exception.InvalidSignatureException(ExceptionMessages.signatureValidationInvalidSenderSignature)
                        }
                    }
                    
                    let messageInvoiceRequestUnsigned = try messageInvoiceRequest.removeMessageSenderSignature()
                    
                    let isCertificateChainValid = try self.validateCertificate(pkiType: messageInvoiceRequest.getMessagePkiType(), certificate: messageInvoiceRequest.pkiData.toString())
                    
                    if (!isCertificateChainValid) {
                        throw Exception.InvalidCertificateChainException(ExceptionMessages.certificateValidationInvalidSenderCertificateCA)
                    }
                    
                    if let isSenderSignatureValid  = try messageInvoiceRequestUnsigned?.validateMessageSignature(signature: messageInvoiceRequest.signature.toString()) {
                        if (!isSenderSignatureValid) {
                            throw Exception.InvalidSignatureException(ExceptionMessages.signatureValidationInvalidSenderSignature)
                        }
                    }
                    
                    if let senderEvCertificate = messageInvoiceRequest.evCert.toString() {
                        if (!senderEvCertificate.isEmpty) {
                            let isEvCertificate = self.certificateValidator.isEvCertificate(clientCertificatesPem: senderEvCertificate)
                            if (!isEvCertificate) {
                                throw Exception.InvalidCertificateException(ExceptionMessages.certificateValidationInvalidSenderCertificateEV)
                            }
                        }
                    }
                    
                    try messageInvoiceRequestUnsigned?.originators.forEach({ (messageOriginator) in
                        try messageOriginator.attestations.forEach { (messageAttestation) in
                            let isCertificateOwnerChainValid = try validateCertificate(pkiType: messageAttestation.getMessagePkiType(), certificate: messageAttestation.pkiData.toString())
                            
                            if (!isCertificateOwnerChainValid) {
                                throw Exception.InvalidCertificateChainException(ExceptionMessages.certificateValidationInvalidOwnerCertificateCA)
                            }
                            
                            let isSignatureValid = try messageAttestation.validateMessageSignature(requireSignature: messageOriginator.isPrimaryForTransaction)
                            
                            if (!isSignatureValid) {
                                throw Exception.InvalidSignatureException(ExceptionMessages.signatureValidationInvalidOwnerSignature)
                            }
                        }
                    })
                    
                    try messageInvoiceRequestUnsigned?.originators.forEach({ (messageOriginator) in
                        try messageOriginator.attestations.forEach { (messageAttestation) in
                            let isCertificateOwnerChainValid = try validateCertificate(pkiType: messageAttestation.getMessagePkiType(), certificate: messageAttestation.pkiData.toString())
                            
                            if (!isCertificateOwnerChainValid) {
                                throw Exception.InvalidCertificateChainException(ExceptionMessages.certificateValidationInvalidOwnerCertificateCA)
                            }
                            
                            let isSignatureValid = try messageAttestation.validateMessageSignature(requireSignature: messageOriginator.isPrimaryForTransaction)
                            
                            if (!isSignatureValid) {
                                throw Exception.InvalidSignatureException(ExceptionMessages.signatureValidationInvalidOwnerSignature)
                            }
                        }
                    })
                    
                    try messageInvoiceRequestUnsigned?.beneficiaries.forEach({ (messageBeneficiary) in
                        try messageBeneficiary.attestations.forEach { (messageAttestation) in
                            let isCertificateOwnerChainValid = try validateCertificate(pkiType: messageAttestation.getMessagePkiType(), certificate: messageAttestation.pkiData.toString())
                            
                            if (!isCertificateOwnerChainValid) {
                                throw Exception.InvalidCertificateChainException(ExceptionMessages.certificateValidationInvalidOwnerCertificateCA)
                            }
                        }
                    })
                    
                    return true
                }
            }
        }
        
        
        return false
    }
    
    func parseInvoiceRequest(invoiceRequestBinary: Data, recipientParameters: RecipientParameters?) throws -> InvoiceRequest? {
        return try self.parseInvoiceRequestBinary(invoiceRequestBinary: invoiceRequestBinary, recipientParameters: recipientParameters)
    }
    
    //MARK: TODO parseInvoiceRequestWithAddressInfo
    
    func parseInvoiceRequestWithAddressInfo(invoiceRequestBinary: Data, recipientParameters: RecipientParameters?) throws -> InvoiceRequest? {
        if let invoiceRequest = try self.parseInvoiceRequestBinary(invoiceRequestBinary: invoiceRequestBinary, recipientParameters: recipientParameters) {
            invoiceRequest.originatorsAddresses.forEach { (output) in
                if let addressInformationService = self.addressInformationService, let script = output.script {
                    let addressInfo = addressInformationService.getAddressInformation(currency: output.currency, address: script)
                    output.addressInformation = addressInfo
                }
            }
            return invoiceRequest
        }
        
        return nil
    }
    
    private func parseInvoiceRequestBinary(invoiceRequestBinary: Data, recipientParameters: RecipientParameters?) throws -> InvoiceRequest?  {
        if let protocolMessageMetadata = try invoiceRequestBinary.extractProtocolMessageMetadata() {
            if let messageInvoiceRequestData = try invoiceRequestBinary.getSerializedMessage(encrypted: protocolMessageMetadata.encrypted, recipientParameters: recipientParameters){
                let messageInvoiceRequest = try messageInvoiceRequestData.toMessageInvoiceRequest()
                return messageInvoiceRequest?.toInvoiceRequest(protocolMessageMetadata: protocolMessageMetadata)
            }
        }
        
        return nil
    }
    
    
    //MARK: PaymentRequest
    
    func createPaymentRequest(paymentRequestParameters: PaymentRequestParameters) throws -> Data? {
        
        try paymentRequestParameters.beneficiaryParameters.validate(required: true, ownerType: OwnerType.beneficiary)
        
        let messagePaymentDetails = paymentRequestParameters.toMessagePaymentDetails()
        
        if let senderParameters = paymentRequestParameters.senderParameters  {
            
            var messagePaymentRequest = try messagePaymentDetails.toPaymentRequest(senderParameters: senderParameters,
                                                                                   paymentParametersVersion: paymentRequestParameters.paymentParametersVersion,
                                                                                   attestationsRequested: paymentRequestParameters.attestationsRequested)
            
            paymentRequestParameters.beneficiaryParameters.forEach({ (beneficiary) in
                var messageBeneficiary = beneficiary.toMessageBeneficiaryWithoutAttestations()
                beneficiary.pkiDataParametersSets?.forEach({ (pkiData) in
                    messageBeneficiary.addAttestation(attestation: pkiData.toMessageAttestation(requireSignature: beneficiary.isPrimaryForTransaction))
                })
                messagePaymentRequest.addBeneficiary(messageBeneficiary: messageBeneficiary)
                
            })
            
            
            let paymentRequest = try messagePaymentRequest.signMessage(senderParameters: senderParameters)?.serializedData()
            
            
            return try paymentRequest?.toProtocolMessageData(messageType: .paymentRequest,
                                                             messageInformation: paymentRequestParameters.messageInformation,
                                                             senderParameters: paymentRequestParameters.senderParameters,
                                                             recipientParameters: paymentRequestParameters.recipientParameters)
        }
        
        return nil
    }
    
    func isPaymentRequestValid(paymentRequestBinary: Data, recipientParameters: RecipientParameters?) throws -> Bool {
        if let protocolMessageMetadata = try paymentRequestBinary.extractProtocolMessageMetadata() {
            if let messagePaymentRequestData = try paymentRequestBinary.getSerializedMessage(encrypted: protocolMessageMetadata.encrypted) {
                if let messagePaymentRequest = try messagePaymentRequestData.toMessagePaymentRequest() {
                    
                    if (protocolMessageMetadata.encrypted) {
                        let isSenderEncryptionSignatureValid = try paymentRequestBinary.validateMessageEncryptionSignature()
                        if (!isSenderEncryptionSignatureValid) {
                            throw Exception.InvalidSignatureException(ExceptionMessages.signatureValidationInvalidSenderSignature)
                        }
                    }
                    
                    let messagePaymentRequestUnsigned = try messagePaymentRequest.removeMessageSenderSignature()
                    
                    let isCertificateChainValid = try self.validateCertificate(pkiType: messagePaymentRequest.getMessagePkiType(), certificate: messagePaymentRequest.senderPkiData.toString())

                    if (!isCertificateChainValid) {
                        throw Exception.InvalidCertificateChainException(ExceptionMessages.certificateValidationInvalidSenderCertificateCA)
                    }
                    
                    if let isSenderSignatureValid  = try messagePaymentRequestUnsigned?.validateMessageSignature(signature: messagePaymentRequest.senderSignature.toString()) {
                        if (!isSenderSignatureValid) {
                            throw Exception.InvalidSignatureException(ExceptionMessages.signatureValidationInvalidSenderSignature)
                        }
                    }
                    
                    try messagePaymentRequestUnsigned?.beneficiaries.forEach({ (messageBeneficiary) in
                        try messageBeneficiary.attestations.forEach { (messageAttestation) in
                            let isCertificateOwnerChainValid = try self.validateCertificate(pkiType: messageAttestation.getMessagePkiType(), certificate: messageAttestation.pkiData.toString())
                            if (!isCertificateOwnerChainValid) {
                                throw Exception.InvalidCertificateChainException(ExceptionMessages.certificateValidationInvalidOwnerCertificateCA)
                            }
                            
                            let isSignatureValid = try messageAttestation.validateMessageSignature(requireSignature: messageBeneficiary.isPrimaryForTransaction)
                            
                            if (!isSignatureValid) {
                                throw Exception.InvalidSignatureException(ExceptionMessages.signatureValidationInvalidOwnerSignature)
                            }
                        }
                    })
                    return true
                }
            }
        }
        return false
    }
    
    func parsePaymentRequest(paymentRequestBinary: Data, recipientParameters: RecipientParameters?) throws -> PaymentRequest? {
        if let protocolMessageMetadata = try paymentRequestBinary.extractProtocolMessageMetadata() {
            if let messagePaymentRequestData = try paymentRequestBinary.getSerializedMessage(encrypted: protocolMessageMetadata.encrypted) {
                if let messagePaymentRequest = try messagePaymentRequestData.toMessagePaymentRequest() {
                    return try messagePaymentRequest.toPaymentRequest(protocolMessageMetadata: protocolMessageMetadata)
                }
            }
        }
        
        return nil
    }
    
    //MARK: Payment

    func createPayment(paymentParameters: PaymentParameters) throws -> Data? {
        
        try paymentParameters.originatorParameters.validate(required: true, ownerType: .originator)
        try paymentParameters.beneficiaryParameters.validate(required: false, ownerType: .beneficiary)
        
        var messagePayment = paymentParameters.toPaymentMessage()
        
        paymentParameters.beneficiaryParameters.forEach { (beneficiaryParameters) in
            var beneficiaryMessage = beneficiaryParameters.toMessageBeneficiaryWithoutAttestations()
            beneficiaryParameters.pkiDataParametersSets?.forEach({ (pkiDataParameters) in
                beneficiaryMessage.addAttestation(attestation: pkiDataParameters.toMessageAttestation(requireSignature: false))
            })
            messagePayment.addBeneficiary(messageBeneficiary: beneficiaryMessage)
        }
        
        paymentParameters.originatorParameters.forEach { (originatorParameters) in
            var originatorMessage = originatorParameters.toMessageOriginatorWithoutAttestations()
            originatorParameters.pkiDataParametersSets?.forEach({ (pkiDataParameters) in
                originatorMessage.addAttestation(attestation: pkiDataParameters.toMessageAttestation(requireSignature: originatorParameters.isPrimaryForTransaction))
            })
            messagePayment.addOriginator(messageOriginator: originatorMessage)
        }
        
        let payment = try messagePayment.serializedData()
        
        return try payment.toProtocolMessageData(messageType: .payment,
                                                  messageInformation: paymentParameters.messageInformation,
                                                  senderParameters: paymentParameters.senderParameters,
                                                  recipientParameters: paymentParameters.recipientParameters)
    }
    
    //MARK: Private methods
    
    private func validateCertificate(pkiType: PkiType, certificate: String?) throws -> Bool {
        guard let certificate = certificate else {
            return false
        }
        switch pkiType {
        case .none:
            return true
        case .x509sha256:
            return try self.certificateValidator.validateCertificate(clientCertificatesPem: certificate)
        }
    }
}
