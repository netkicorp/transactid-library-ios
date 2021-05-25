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
    
    public var merchantData: String? = nil
    
    /**
     * One or more valid, signed Bitcoin transactions that fully pay the PaymentRequest.
     */
    public var transactions: Array<Data> = []
    
    /**
     * One or more outputs where the merchant may return funds, if necessary.
     */
    public var outputs: Array<Output> = []
    
    /**
     * UTF-8 encoded, plain-text note from the customer to the merchant.
     */
    public var memo: String? = nil
    
    /**
     * Originators account.
     */
    public var originators: Array<Originator> = []
    
    /**
     * Beneficiaries account.
     */
    public var beneficiaries: Array<Beneficiary> = []
    
    /**
     * Metadata for the protocol message.
     */
    public var protocolMessageMetadata: ProtocolMessageMetadata? = nil
    
}
