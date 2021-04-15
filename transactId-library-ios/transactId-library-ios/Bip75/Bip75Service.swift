//
//  Bip75Service.swift
//  transactId-library-ios
//
//  Created by Developer on 09.02.2021.
//

import Foundation

/**
 * Generate Bip75 protocol messages.
 */
protocol Bip75Service {
    
    /**
     * Create InvoiceRequest message.
     *
     * @param invoiceRequestParameters data to create the InvoiceRequest.
     * @return binary object of the message created.
     * @throws InvalidOwnersException if the provided list of owners is not valid.
     * @throws EncryptionException if there is an error while creating the encrypted message.
     */
    func createInvoiceRequest(invoiceRequestParameters: InvoiceRequestParameters) throws -> Data?
    
    /**
     * Validate if a binary InvoiceRequest is valid.
     *
     * @param invoiceRequestBinary binary data to validate.
     * @param recipientParameters information of the recipient of the message, the RecipientParameters.EncryptionParameters is mandatory to handle encrypted messages.
     * @return true if is valid.
     * @exception InvalidObjectException if the binary is malformed.
     * @exception InvalidSignatureException if the signature in the binary is not valid.
     * @exception InvalidCertificateException if there is a problem with the certificates.
     * @exception InvalidCertificateChainException if the certificate chain is not valid.
     * @exception EncryptionException if there is an error decrypting or validating the encryption.
     */
    func isInvoiceRequestValid(invoiceRequestBinary: Data, recipientParameters: RecipientParameters?) throws -> Bool
    
    /**
     * Parse binary InvoiceRequest.
     *
     * @param invoiceRequestBinary binary data with the message to parse.
     * @param recipientParameters information of the recipient of the message, the RecipientParameters.EncryptionParameters is mandatory to handle encrypted messages.
     * @return InvoiceRequest parsed.
     * @exception InvalidObjectException if the binary is malformed.
     * @exception EncryptionException if there is an error decrypting or validating the encryption.
     */
    func parseInvoiceRequest(invoiceRequestBinary: Data, recipientParameters: RecipientParameters?) throws -> InvoiceRequest?
    
    /**
     * Parse binary InvoiceRequest and also get the detailed information of the addresses.
     *
     * @param invoiceRequestBinary binary data with the message to parse.
     * @param recipientParameters information of the recipient of the message, the RecipientParameters.EncryptionParameters is mandatory to handle encrypted messages.
     * @return InvoiceRequest parsed with the detailed information for each address.
     * @exception InvalidObjectException if the binary is malformed.
     * @exception AddressProviderErrorException if there is an error fetching the information from the provider.
     * @exception AddressProviderUnauthorizedException if there is an error with the authorization to connect to the provider.
     * @exception EncryptionException if there is an error decrypting or validating the encryption.
     */
    func parseInvoiceRequestWithAddressInfo(invoiceRequestBinary: Data, recipientParameters: RecipientParameters?) throws -> InvoiceRequest?
    
    /**
     * Create binary PaymentRequest.
     *
     * @param paymentRequestParameters data to create the PaymentRequest.
     * @return binary object of the message created.
     * @throws InvalidOwnersException if the provided list of owners is not valid.
     * @throws EncryptionException if there is an error while creating the encrypted message.
     */
    func createPaymentRequest(paymentRequestParameters: PaymentRequestParameters) throws -> Data?
    
    /**
     * Validate if a binary PaymentRequest is valid.
     *
     * @param paymentRequestBinary binary data to validate.
     * @param recipientParameters information of the recipient of the message, the RecipientParameters.EncryptionParameters is mandatory to handle encrypted messages.
     * @return true if is valid.
     * @exception InvalidObjectException if the binary is malformed.
     * @exception InvalidSignatureException if the signature in the binary is not valid.
     * @exception InvalidCertificateException if there is a problem with the certificates.
     * @exception InvalidCertificateChainException if the certificate chain is not valid.
     * @exception EncryptionException if there is an error decrypting or validating the encryption.
     */
    func isPaymentRequestValid(paymentRequestBinary: Data, recipientParameters: RecipientParameters?) throws -> Bool
    
    /**
     * Parse binary PaymentRequest.
     *
     * @param paymentRequestBinary binary data with the message to parse.
     * @param recipientParameters information of the recipient of the message, the RecipientParameters.EncryptionParameters is mandatory to handle encrypted messages.
     * @return PaymentRequest parsed.
     * @exception InvalidObjectException if the binary is malformed.
     * @exception EncryptionException if there is an error decrypting or validating the encryption.
     */
    func parsePaymentRequest(paymentRequestBinary: Data, recipientParameters: RecipientParameters?) throws -> PaymentRequest?
    
    /**
     * Create binary Payment.
     *
     * @param paymentParameters data to create the Payment.
     * @return binary object of the message created.
     * @throws EncryptionException if there is an error while creating the encrypted message.
     */
    func createPayment(paymentParameters: PaymentParameters) throws -> Data?
    
    /**
     * Validate if a binary Payment is valid.
     *
     * @param paymentBinary binary data to validate.
     * @param recipientParameters information of the recipient of the message, the RecipientParameters.EncryptionParameters is mandatory to handle encrypted messages.
     * @return true if is valid.
     * @exception InvalidObjectException if the binary is malformed.
     * @exception InvalidSignatureException if the signature in the binary is not valid.
     * @exception InvalidCertificateException if there is a problem with the certificates.
     * @exception InvalidCertificateChainException if the certificate chain is not valid.
     * @exception EncryptionException if there is an error decrypting or validating the encryption.
     */
    func isPaymentValid(paymentBinary: Data, recipientParameters: RecipientParameters?) throws -> Bool
    
    /**
     * Parse binary Payment.
     *
     * @param paymentBinary binary data with the message to parse.
     * @param recipientParameters information of the recipient of the message, the RecipientParameters.EncryptionParameters is mandatory to handle encrypted messages.
     * @return Payment parsed.
     * @exception InvalidObjectException if the binary is malformed.
     * @exception EncryptionException if there is an error decrypting or validating the encryption.
     */
    func parsePayment(paymentBinary: Data, recipientParameters: RecipientParameters?) throws -> Payment?
    
}
