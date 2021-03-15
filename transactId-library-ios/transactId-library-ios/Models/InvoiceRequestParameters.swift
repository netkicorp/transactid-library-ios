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
public class InvoiceRequestParameters {
    
    public init() { }

    /**
     * Array of originators for this transaction.
     */
    public var originatorParameters: Array<OriginatorParameters>? = nil
    
    /**
     * The sender of the protocol message.
     */
    public var senderParameters: SenderParameters? = nil
    
    /**
     * Array of attestations requested for the transaction.
     */
    public var attestationsRequested: Array<Attestation>? = nil
    
    /**
     * Integer-number-of-satoshis.
     */
    public var amount: Int = 0
    
    /**
     * Human-readable description of invoice request for the receiver.
     */
    public var memo: String? = nil
    
    /**
     * Where the payment comes from.
     */
    public var originatorsAddresses: Array<Output>? = nil
    
    /**
     * Array of beneficiaries for this transaction.
     */
    public var beneficiaryParameters: Array<BeneficiaryParameters>? = nil
    
    /**
     * Information of the recipient of the message.
     */
    public var recipientParameters: RecipientParameters? = RecipientParameters()
    
    /**
     * Secure (usually TLS-protected HTTP) location where an EncryptedProtocolMessage SHOULD be sent when ready.
     */
    public var notificationUrl: String? = nil
    
    /**
     * Status and information of the protocol message status, by default "OK".
     */
    public var messageInformation: MessageInformation = MessageInformation()
    
    
}
