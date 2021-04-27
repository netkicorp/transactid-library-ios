//
//  Bip75Netki.swift
//  transactId-library-ios
//
//  Created by Developer on 09.02.2021.
//

import Foundation

class Bip75Netki: Bip75 {
    
    private let bip75Service: Bip75Service
    
    init(bip75Service: Bip75Service) {
        self.bip75Service = bip75Service
    }
    
    func createInvoiceRequest(invoiceRequestParameters: InvoiceRequestParameters) throws -> Data? {
        return try self.bip75Service.createInvoiceRequest(invoiceRequestParameters: invoiceRequestParameters)
    }
    
    func isInvoiceRequestValid(invoiceRequestBinary: Data, recipientParameters: RecipientParameters?) throws -> Bool {
        return try self.bip75Service.isInvoiceRequestValid(invoiceRequestBinary: invoiceRequestBinary, recipientParameters: recipientParameters)
    }
    
    func parseInvoiceRequest(invoiceRequestBinary: Data, recipientParameters: RecipientParameters?) throws -> InvoiceRequest? {
        return try self.bip75Service.parseInvoiceRequest(invoiceRequestBinary: invoiceRequestBinary, recipientParameters: recipientParameters)
    }
    
    func parseInvoiceRequestWithAddressInfo(invoiceRequestBinary: Data, recipientParameters: RecipientParameters?) throws -> InvoiceRequest? {
        return try self.bip75Service.parseInvoiceRequestWithAddressInfo(invoiceRequestBinary: invoiceRequestBinary, recipientParameters: recipientParameters)
    }
    
    func createPaymentRequest(paymentRequestParameters: PaymentRequestParameters) throws -> Data? {
        return try self.bip75Service.createPaymentRequest(paymentRequestParameters: paymentRequestParameters)
    }
    
    func isPaymentRequestValid(paymentRequestBinary: Data, recipientParameters: RecipientParameters?) throws -> Bool {
        return try self.bip75Service.isPaymentRequestValid(paymentRequestBinary: paymentRequestBinary, recipientParameters: recipientParameters)
    }
    
    func parsePaymentRequest(paymentRequestBinary: Data, recipientParameters: RecipientParameters?) throws -> PaymentRequest? {
        return try self.bip75Service.parsePaymentRequest(paymentRequestBinary: paymentRequestBinary, recipientParameters: recipientParameters)
    }
    
    func createPayment(paymentParameters: PaymentParameters) throws -> Data? {
        return try self.bip75Service.createPayment(paymentParameters: paymentParameters)
    }
    
    func isPaymentValid(paymentBinary: Data, recipientParameters: RecipientParameters?) throws -> Bool {
        return try self.bip75Service.isPaymentValid(paymentBinary: paymentBinary, recipientParameters: recipientParameters)
    }
    
    func parsePayment(paymentBinary: Data, recipientParameters: RecipientParameters?) throws -> Payment? {
        return try self.bip75Service.parsePayment(paymentBinary: paymentBinary, recipientParameters: recipientParameters)
    }
    
    func createPaymentACK(paymentAckParameters: PaymentAckParameters) throws -> Data? {
        return try self.bip75Service.createPaymentACK(paymentAckParameters: paymentAckParameters)
    }
    
    func isPaymentACKValid(paymentAckBinary: Data, recipientParameters: RecipientParameters?) throws -> Bool {
        return try self.bip75Service.isPaymentACKValid(paymentAckBinary: paymentAckBinary, recipientParameters: recipientParameters)
    }
    
    func parsePaymentACK(paymentAckBinary: Data, recipientParameters: RecipientParameters?) throws -> PaymentACK? {
        return try self.bip75Service.parsePaymentACK(paymentAckBinary: paymentAckBinary, recipientParameters: recipientParameters)
    }
    
}
