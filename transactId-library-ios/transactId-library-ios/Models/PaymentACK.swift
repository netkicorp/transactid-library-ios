//
//  PaymentACK.swift
//  transactId-library-ios
//
//  Created by Developer on 16.04.2021.
//

import Foundation

/**
 * Representation of PaymentACK message.
 */
public class PaymentACK {
    
    /**
     * Copy of the Payment message that triggered this PaymentACK.
     */
    
    public var payment: Payment? = nil
    
    /**
     * UTF-8 encoded note that should be displayed to the customer giving the status of the transaction.
     * (e.g. "Payment of 1 BTC for eleven tribbles accepted for processing.").
     */
    public var memo: String? = nil
    
    /**
     * Metadata for the protocol message.
     */
    public var protocolMessageMetadata: ProtocolMessageMetadata? = nil
    
    
}
