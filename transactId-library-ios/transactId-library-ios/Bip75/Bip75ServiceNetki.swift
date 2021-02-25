//
//  Bip75ServiceNetki.swift
//  transactId-library-ios
//
//  Created by Developer on 09.02.2021.
//

import Foundation

class Bip75ServiceNetki: Bip75Service {
    
    private let certificateValidator: CertificateValidator
        
    init(certificateValidator: CertificateValidator) {
        self.certificateValidator = certificateValidator
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
        
        return try messageInvoiceRequest.serializedData()
    }
    
    func isInvoiceRequestValid(invoiceRequestBinary: Data, recipientParameters: RecipientParameters?) throws -> Bool {
        return false
    }
    
    func parseInvoiceRequest(invoiceRequestBinary: Data, recipientParameters: RecipientParameters?) throws -> InvoiceRequest? {
        return nil
    }
    
    

}
