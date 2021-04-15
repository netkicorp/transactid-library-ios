//
//  PaymentAckParameters.swift
//  transactId-library-ios
//
//  Created by Developer on 15.04.2021.
//

import Foundation

public class PaymentAckParameters {
    
    public init() { }
    
    /**
     * Data to create the Payment.
     */
    public var payment: Payment? = nil
    
    /**
     * Note that should be displayed to the customer.
     */
    public var memo: String? = ""
    
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
