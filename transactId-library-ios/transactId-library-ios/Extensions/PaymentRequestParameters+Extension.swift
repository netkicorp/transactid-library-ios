//
//  PaymentRequestParameters+Extension.swift
//  transactId-library-ios
//
//  Created by Developer on 06.04.2021.
//

import Foundation

extension PaymentRequestParameters {
    
    func toMessagePaymentDetails() -> MessagePaymentDetails {
        var messagePaymentDetails: MessagePaymentDetails = MessagePaymentDetails()
        
        messagePaymentDetails.network = self.network
        messagePaymentDetails.time = UInt64(self.time * 1000)
        
        if let expires = self.expires {
            messagePaymentDetails.expires = UInt64(expires * 1000)
        }
        messagePaymentDetails.memo = self.memo ?? ""
        messagePaymentDetails.paymentUrl = self.paymentUrl ?? ""
        
        if let merchantData = self.merchantData {
            messagePaymentDetails.merchantData = merchantData.toByteString()
        }
        
        self.beneficiariesAddresses?.forEach({ (output) in
            messagePaymentDetails.addBeneficiariesAddresses(beneficiariesAddress: output.toMessageOutput())
        })
        
        return messagePaymentDetails
    }
}
