//
//  InvoiceRequestParameters+Extension.swift
//  transactId-library-ios
//
//  Created by Developer on 24.02.2021.
//

import Foundation

extension InvoiceRequestParameters {
    
    func toMessageInvoiceRequestUnsigned() -> MessageInvoiceRequest {
        
        var invoiceRequest = MessageInvoiceRequest()
        
        invoiceRequest.amount = UInt64(self.amount)
        invoiceRequest.memo = self.memo ?? ""
        invoiceRequest.notificationURL = self.notificationUrl ?? ""
        invoiceRequest.pkiType = self.senderParameters?.pkiDataParameters?.type.rawValue ?? PkiType.x509sha256.rawValue
        invoiceRequest.pkiData = self.senderParameters?.pkiDataParameters?.certificatePem?.data(using: .utf8) ?? Data()
        invoiceRequest.signature = "".data(using: .utf8) ?? Data()
        invoiceRequest.evCert = self.senderParameters?.evCertificatePem?.data(using: .utf8) ?? Data()
        
        self.originatorsAddresses?.forEach({ (output) in
            invoiceRequest.addOutput(output: output.toMessageOutput())
        })
        
        self.attestationsRequested?.forEach({ (attestation) in
            invoiceRequest.addAttestation(attestationType: MessageAttestationType(rawValue: attestation.rawValue) ?? MessageAttestationType())
        })
        
        if let recipientParameters = self.recipientParameters {
            invoiceRequest.recipientChainAddress = recipientParameters.chainAddress ?? ""
            invoiceRequest.recipientVaspName = recipientParameters.vaspName ?? ""
        }
        
        return invoiceRequest
        
    }
}
