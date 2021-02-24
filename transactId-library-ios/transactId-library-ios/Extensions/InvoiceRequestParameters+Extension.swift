//
//  InvoiceRequestParameters+Extension.swift
//  transactId-library-ios
//
//  Created by Developer on 24.02.2021.
//

import Foundation

extension InvoiceRequestParameters {
    
    func toMessageInvoiceRequestUnsigned() -> Messages.InvoiceRequest {
        
        var invoiceRequest = Messages.InvoiceRequest()
        
        invoiceRequest.amount = UInt64(self.amount)
        invoiceRequest.memo = self.memo ?? ""
        invoiceRequest.notificationURL = self.notificationUrl ?? ""
        invoiceRequest.pkiType = self.senderParameters?.pkiDataParameters?.type.rawValue ?? PkiType.X509SHA256.rawValue
        invoiceRequest.pkiData = self.senderParameters?.pkiDataParameters?.certificatePem?.data(using: .utf8) ?? Data()
        invoiceRequest.signature = "".data(using: .utf8) ?? Data()
        invoiceRequest.evCert = self.senderParameters?.evCertificatePem?.data(using: .utf8) ?? Data()
        return invoiceRequest
        
    }
}
