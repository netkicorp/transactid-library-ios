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
                
//                    let isCertificateChainValid = try self.validateCertificate(pkiType: messageInvoiceRequest.getMessagePkiType(), certificate: messageInvoiceRequest.pkiData.toString())
//
//                    if (!isCertificateChainValid) {
//                        throw Exception.InvalidCertificateChainException(ExceptionMessages.certificateValidationInvalidSenderCertificateCA)
//                    }
                    
                    if let isSenderSignatureValid  = try messageInvoiceRequestUnsigned?.validateMessageSignature(signature: messageInvoiceRequest.signature.toString()) {
                        if (!isSenderSignatureValid) {
                            throw Exception.InvalidSignatureException(ExceptionMessages.signatureValidationInvalidSenderSignature)
                        }
                    }
                    
                }
            }
        }

        
        return false
    }
    
    func parseInvoiceRequest(invoiceRequestBinary: Data, recipientParameters: RecipientParameters?) throws -> InvoiceRequest? {
        return try self.parseInvoiceRequestBinary(invoiceRequestBinary: invoiceRequestBinary, recipientParameters: recipientParameters)
    }
    
    //TODO: parseInvoiceRequestWithAddressInfo
    
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
