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
    var amount: Int? = 0
    
    /**
     * Human-readable description of invoice request for the receiver.
     */
    var memo: String? = nil
    
    /**
     * Secure (usually TLS-protected HTTP) location where an EncryptedProtocolMessage SHOULD be sent when ready.
     */
    var notificationUrl: String? = nil
    
    /**
     * Originators account.
     */
    var originators: Array<Originator> = []
    
    /**
     * Beneficiaries account.
     */
    
    var beneficiaries: Array<Beneficiary> = []
    
    /**
     * Where the payment comes from.
     */
    var originatorsAddresses: Array<Output> = []
    
    /**
     * List of attestations requested
     */
    
    var attestationsRequested: Array<Attestation> = []
    
    /**
     * Type of sender's pki data.
     */
    
    var senderPkiType: PkiType? = nil
    
    /**
     * Sender's pki data, depends on senderPkiType.
     */
    
    var senderPkiData: String? = nil
    
    /**
     * Sender's Signature of the whole message.
     */
    var senderSignature: String? = nil
    
    /**
     * EV Certificate in PEM format.
     */
    var senderEvCert: String? = nil
    
    /**
     * Recipient's vasp name
     */
    var recipientVaspName: String? = nil
    
    /**
     * Recipient's chain address
     */
    var recipientChainAddress: String? = nil
    
    /**
     * Metadata for the protocol message.
     */
    var protocolMessageMetadata: ProtocolMessageMetadata? = nil
}
