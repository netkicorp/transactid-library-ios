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
    
    public func createPaymentRequest(paymentRequestParameters: PaymentRequestParameters) throws -> Data? {
        return try self.bip75.createPaymentRequest(paymentRequestParameters: paymentRequestParameters)
    }
    
    public func isPaymentRequestValid(paymentRequestBinary: Data, recipientParameters: RecipientParameters?) throws -> Bool {
        return try self.bip75.isPaymentRequestValid(paymentRequestBinary: paymentRequestBinary, recipientParameters: recipientParameters)
    }
    
    public func parsePaymentRequest(paymentRequestBinary: Data, recipientParameters: RecipientParameters?) throws -> PaymentRequest? {
        return try self.bip75.parsePaymentRequest(paymentRequestBinary: paymentRequestBinary, recipientParameters: recipientParameters)
    }
    
    public func createPayment(paymentParameters: PaymentParameters) throws -> Data? {
        return try self.bip75.createPayment(paymentParameters: paymentParameters)
    }
    
    public func isPaymentValid(paymentBinary: Data, recipientParameters: RecipientParameters?) throws -> Bool {
        return try self.bip75.isPaymentValid(paymentBinary: paymentBinary, recipientParameters: recipientParameters)
    }
    
    public func parsePayment(paymentBinary: Data, recipientParameters: RecipientParameters?) throws -> Payment? {
        return try self.bip75.parsePayment(paymentBinary: paymentBinary, recipientParameters: recipientParameters)
    }
    
    public func createPaymentACK(paymentAckParameters: PaymentAckParameters) throws -> Data? {
        return try self.bip75.createPaymentACK(paymentAckParameters: paymentAckParameters)
    }
    
}
