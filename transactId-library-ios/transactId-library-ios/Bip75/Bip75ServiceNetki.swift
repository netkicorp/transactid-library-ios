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
        
        try invoiceRequestParameters.originatorParameters?.validate(required: true, ownerType: .ORIGINATOR)
        try invoiceRequestParameters.beneficiaryParameters?.validate(required: false, ownerType: .BENEFICIARY)

        let messageInvoiceRequest = invoiceRequestParameters.toMessageInvoiceRequestUnsigned()
        
        invoiceRequestParameters.beneficiaryParameters?.forEach({ (beneficiary) in
            
            
            beneficiary.pkiDataParametersSets?.forEach({ (pkiData) in
                <#code#>
            })
            
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
