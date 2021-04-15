//
//  Payment.swift
//  transactId-library-ios
//
//  Created by Developer on 14.04.2021.
//

import Foundation

/**
 * Representation of Payment message.
 */
public class Payment {
    
    /**
     * Copied from PaymentDetails.merchantData.
     * Merchants may use invoice numbers or any other data they require to match Payments to PaymentRequests.
     */
    
    var merchantData: String? = nil
    
    /**
     * One or more valid, signed Bitcoin transactions that fully pay the PaymentRequest.
     */
    var transactions: Array<Data> = []
    
    /**
     * One or more outputs where the merchant may return funds, if necessary.
     */
    var outputs: Array<Output> = []
    
    /**
     * UTF-8 encoded, plain-text note from the customer to the merchant.
     */
    var memo: String? = nil
    
    /**
     * Originators account.
     */
    var originators: Array<Originator> = []
    
    /**
     * Beneficiaries account.
     */
    var beneficiaries: Array<Beneficiary> = []
    
    /**
     * Metadata for the protocol message.
     */
    var protocolMessageMetadata: ProtocolMessageMetadata? = nil
    
}
