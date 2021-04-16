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
    
    var payment: Payment? = nil
    
    /**
     * UTF-8 encoded note that should be displayed to the customer giving the status of the transaction.
     * (e.g. "Payment of 1 BTC for eleven tribbles accepted for processing.").
     */
    var memo: String? = nil
    
    /**
     * Metadata for the protocol message.
     */
    var protocolMessageMetadata: ProtocolMessageMetadata? = nil
    
    
}
