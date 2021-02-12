//
//  TransactId.swift
//  transactId-library-ios
//
//  Created by Developer on 02.02.2021.
//

import Foundation

public class TransactId {
    
    private var bip75: Bip75
    
    init(trustStore: TrustStore, autorizationKey: String? = nil, developmentMode: Bool = false) {
        self.bip75 = Bip75Factory.shared().getInstance(trustStore: trustStore, autorizationKey: autorizationKey, developmentMode: developmentMode)
    }
    
    func createInvoiceRequest(invoiceRequestParameters: InvoiceRequestParameters) throws -> Data? {
        return try self.bip75.createInvoiceRequest(invoiceRequestParameters: invoiceRequestParameters)
    }
    
    
    func isInvoiceRequestValid(invoiceRequestBinary: Data,
                               recipientParameters: RecipientParameters? = nil) throws -> Bool {
        return try self.bip75.isInvoiceRequestValid(invoiceRequestBinary: invoiceRequestBinary, recipientParameters: recipientParameters)
    }
    
    func parseInvoiceRequest(invoiceRequestBinary: Data,
                             recipientParameters: RecipientParameters? = nil) throws -> InvoiceRequest? {
        return try self.bip75.parseInvoiceRequest(invoiceRequestBinary: invoiceRequestBinary, recipientParameters: recipientParameters)
    }
    
}
