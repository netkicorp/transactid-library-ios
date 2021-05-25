//
//  InvoiceRequest.swift
//  transactId-library-ios
//
//  Created by Developer on 09.02.2021.
//

import Foundation

public class InvoiceRequest {
    
    /**
     * Integer-number-of-satoshis.
     */
    public var amount: Int? = 0
    
    /**
     * Human-readable description of invoice request for the receiver.
     */
    public var memo: String? = nil
    
    /**
     * Secure (usually TLS-protected HTTP) location where an EncryptedProtocolMessage SHOULD be sent when ready.
     */
    public var notificationUrl: String? = nil
    
    /**
     * Originators account.
     */
    public var originators: Array<Originator> = []
    
    /**
     * Beneficiaries account.
     */
    
    public var beneficiaries: Array<Beneficiary> = []
    
    /**
     * Where the payment comes from.
     */
    public var originatorsAddresses: Array<Output> = []
    
    /**
     * List of attestations requested
     */
    public var attestationsRequested: Array<Attestation> = []
    
    /**
     * Type of sender's pki data.
     */
    public var senderPkiType: PkiType? = nil
    
    /**
     * Sender's pki data, depends on senderPkiType.
     */
    public var senderPkiData: String? = nil
    
    /**
     * Sender's Signature of the whole message.
     */
    public var senderSignature: String? = nil
    
    /**
     * EV Certificate in PEM format.
     */
    public var senderEvCert: String? = nil
    
    /**
     * Recipient's vasp name
     */
    public var recipientVaspName: String? = nil
    
    /**
     * Recipient's chain address
     */
    public var recipientChainAddress: String? = nil
    
    /**
     * Metadata for the protocol message.
     */
    public var protocolMessageMetadata: ProtocolMessageMetadata? = nil
}
