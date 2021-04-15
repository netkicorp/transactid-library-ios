//
//  Payment+Extension.swift
//  transactId-library-ios
//
//  Created by Developer on 15.04.2021.
//

import Foundation

extension Payment {
    
    /**
     * Transform Payment object to MessagePaymentACK object.
     *
     * @return MessagePaymentACK.
     */
    func toMessagePaymentACK(memo: String?) -> MessagePaymentACK {
        
        var messagePaymentACK = MessagePaymentACK()
        messagePaymentACK.payment = self.toMessagePayment()
        messagePaymentACK.memo = memo ?? ""
        
        return messagePaymentACK
        
    }
    
    /**
     * Transform Payment object to MessagePayment object.
     *
     * @return MessagePayment.
     */
    func toMessagePayment() -> MessagePayment {
        var messagePayment = MessagePayment()
        
        if let merchantData = self.merchantData {
            messagePayment.merchantData = merchantData.toByteString()
        }
        if let memo = self.memo {
            messagePayment.memo = memo
        }
        
        self.transactions.forEach { (transaction) in
            messagePayment.addTransaction(transaction: transaction)
        }
        self.outputs.forEach { (output) in
            messagePayment.addRefund(messageOutput: output.toMessageOutput())
        }
        
        self.beneficiaries.forEach { (beneficiary) in
            messagePayment.addBeneficiary(messageBeneficiary: beneficiary.toMessageBeneficiary())
        }
        
        self.originators.forEach { (originator) in
            messagePayment.addOriginator(messageOriginator: originator.toMessageOriginator())
        }
        
        return messagePayment
    }
}
