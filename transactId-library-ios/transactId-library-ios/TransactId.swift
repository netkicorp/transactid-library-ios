//
//  TransactId.swift
//  transactId-library-ios
//
//  Created by Developer on 02.02.2021.
//

import Foundation

public class TransactId {
    
    private var bip75: Bip75
    
    public init(trustStore: TrustStore? = nil, autorizationKey: String? = nil, developmentMode: Bool = false) {
        self.bip75 = Bip75Factory.shared().getInstance(trustStore: trustStore, autorizationKey: autorizationKey, developmentMode: developmentMode)
    }
    
    public func createInvoiceRequest(invoiceRequestParameters: InvoiceRequestParameters) throws -> Data? {
        return try self.bip75.createInvoiceRequest(invoiceRequestParameters: invoiceRequestParameters)
    }
    
    
    public func isInvoiceRequestValid(invoiceRequestBinary: Data,
                               recipientParameters: RecipientParameters? = nil) throws -> Bool {
        return try self.bip75.isInvoiceRequestValid(invoiceRequestBinary: invoiceRequestBinary, recipientParameters: recipientParameters)
    }
    
    public func parseInvoiceRequest(invoiceRequestBinary: Data,
                             recipientParameters: RecipientParameters? = nil) throws -> InvoiceRequest? {
        return try self.bip75.parseInvoiceRequest(invoiceRequestBinary: invoiceRequestBinary, recipientParameters: recipientParameters)
    }
    
}
