//
//  PaymentParameters.swift
//  transactId-library-ios
//
//  Created by Developer on 12.04.2021.
//

import Foundation

/**
 * Data to create Payment message.
 */
public class PaymentParameters {
    
    public init() { }
    
    /**
     * Copied from PaymentDetails.merchant_data.
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
     * Array of originators for this transaction.
     */
    public var originatorParameters: Array<OriginatorParameters> = []
    
    /**
     * List of beneficiaries for this transaction.
     */
    public var beneficiaryParameters: Array<BeneficiaryParameters> = []
    
    /**
     * The sender of the protocol message.
     */
    public var senderParameters: SenderParameters? = nil
    
    /**
     * Information of the recipient of the message.
     */
    public var recipientParameters: RecipientParameters? = nil
    
    /**
     * Status and information of the protocol message status, by default "OK".
     */
    public var messageInformation: MessageInformation = MessageInformation()
    
}
