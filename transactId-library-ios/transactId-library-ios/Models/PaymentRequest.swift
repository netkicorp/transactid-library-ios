//
//  PaymentRequest.swift
//  transactId-library-ios
//
//  Created by Developer on 08.04.2021.
//

import Foundation

public class PaymentRequest {
    
    /**
     * Version of the protocol buffer object.
     */
    public var paymentDetailsVersion: Int? = 1
    
    /**
     * Either "main" for payments on the production Bitcoin network, or "test" for payments on test network.
     */
    public var network: String? = "main"
    
    /**
     * Where payment should be sent.
     */
    public var beneficiariesAddresses: Array<Output> = []
    
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
    public var beneficiaries: Array<Beneficiary> = []
    
    /**
     * Array of attestations requested for the transaction.
     */
    public var attestationsRequested: Array<Attestation> = []
    
    /**
     * Type of sender's pki data.
     */
    
    public var senderPkiType: PkiType? = PkiType.none
    
    /**
     * Sender's pki data, depends on senderPkiType.
     */
    
    public var senderPkiData: String? = nil
    
    /**
     * Sender's Signature of the whole message.
     */
    public var senderSignature: String? = nil
    
    /**
     * Metadata for the protocol message.
     */
     public var protocolMessageMetadata: ProtocolMessageMetadata? = nil
    
}
