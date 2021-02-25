//
//  BeneficiaryParameters+Extension.swift
//  transactId-library-ios
//
//  Created by Developer on 25.02.2021.
//

import Foundation

extension BeneficiaryParameters {
    
    func toMessageBeneficiaryWithoutAttestations() -> MessageBeneficiary {
        var messageBeneficiary = MessageBeneficiary()
        messageBeneficiary.isPrimaryForTransaction = self.isPrimaryForTransaction
        return messageBeneficiary
    }
    
}
