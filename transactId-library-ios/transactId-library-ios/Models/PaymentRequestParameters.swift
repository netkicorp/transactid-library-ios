//
//  PaymentRequestParameters.swift
//  transactId-library-ios
//
//  Created by Developer on 06.04.2021.
//

import Foundation

/**
 * Representation of PaymentDetails message.
 */
public class PaymentRequestParameters {
    
    public init() { }
    
    /**
     * Either "main" for payments on the production Bitcoin network, or "test" for payments on test network.
     */
    public var network: String = "main"
    
    /**
     * Where payment should be sent.
     */
    
    public var beneficiariesAddresses: Array<Output>? = nil
    
    /**
     * Unix timestamp (seconds since 1-Jan-1970 UTC) when the PaymentRequest was created.
     */
    public var time: TimeInterval = Date().timeIntervalSince1970
    
    /**
     * Unix timestamp (UTC) after which the PaymentRequest should be considered invalid.
     */
    public var expires: TimeInterval? = nil
    
    /**
     * UTF-8 encoded, plain-text (no formatting) note that should be displayed to the customer,
     * explaining what this PaymentRequest is for.
     */
    public var memo: String? = nil
    
    /**
     * Secure (usually https) location where a Payment message (see below) may be sent to obtain a PaymentACK.
     */
    public var paymentUrl: String? = nil
    
    /**
     * Arbitrary data that may be used by the merchant to identify the PaymentRequest.
     */
    public var merchantData: String? = nil
    
    /**
     * Array of beneficiaries for this transaction.
     */
    public var beneficiaryParameters: Array<BeneficiaryParameters> = []
    
    /**
     * The sender of the protocol message.
     */
    public var senderParameters: SenderParameters? = nil
    
    /**
     * Array of attestations requested for the transaction.
     */
    public var attestationsRequested: Array<Attestation> = []
    
    /**
     * Information of the recipient of the message.
     */
    public var recipientParameters: RecipientParameters? = nil
    
    /**
     * Status and information of the protocol message status, by default "OK".
     */
    public var messageInformation: MessageInformation = MessageInformation()
    
    /**
     * Version of the PaymentDetails message.
     */
    public var paymentParametersVersion: Int = 1
}
