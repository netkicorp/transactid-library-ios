//
//  PaymentParameters+Extension.swift
//  transactId-library-ios
//
//  Created by Developer on 12.04.2021.
//

import Foundation

/**
 * Transform PaymentParameters object to MessagePayment.
 *
 * @return MessagePayment.
 */

extension PaymentParameters {
    
    func toPaymentMessage() -> MessagePayment {
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
        
        return messagePayment
    }
}
