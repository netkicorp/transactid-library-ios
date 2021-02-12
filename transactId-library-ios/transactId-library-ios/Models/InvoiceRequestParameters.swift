//
//  InvoiceRequestParameters.swift
//  transactId-library-ios
//
//  Created by Developer on 09.02.2021.
//

import Foundation

/**
 * Data to create InvoiceRequest message.
 */
class InvoiceRequestParameters {
    
    /**
     * List of originators for this transaction.
     */
    var originatorParameters: Array<OriginatorParameters>? = nil
    
    /**
     * The sender of the protocol message.
     */
    var senderParameters: SenderParameters? = nil
    
    /**
     * List of attestations requested for the transaction.
     */
    var attestationsRequested: Array<Attestation>? = nil
    
    /**
     * Integer-number-of-satoshis.
     */
    var amount: Int = 0
    
    /**
     * Human-readable description of invoice request for the receiver.
     */
    var memo: String? = nil
    
    /**
     * Where the payment comes from.
     */
    var originatorsAddresses: Array<Output>? = nil
    
    /**
     * List of beneficiaries for this transaction.
     */
    var beneficiaryParameters: Array<BeneficiaryParameters>? = nil
    
    /**
     * Information of the recipient of the message.
     */
    var recipientParameters: RecipientParameters? = RecipientParameters()
    
    /**
     * Secure (usually TLS-protected HTTP) location where an EncryptedProtocolMessage SHOULD be sent when ready.
     */
    var notificationUrl: String? = nil
    
    /**
     * Status and information of the protocol message status, by default "OK".
     */
    var messageInformation: MessageInformation = MessageInformation()
    
}
