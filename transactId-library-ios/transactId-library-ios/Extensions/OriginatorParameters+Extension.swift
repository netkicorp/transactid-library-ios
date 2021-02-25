//
//  OriginatorParameters+Extension.swift
//  transactId-library-ios
//
//  Created by Developer on 25.02.2021.
//

import Foundation

extension OriginatorParameters {
    
    func toMessageOriginatorWithoutAttestations() -> MessageOriginator {
        var messageOriginator = MessageOriginator()
        messageOriginator.isPrimaryForTransaction = self.isPrimaryForTransaction
        return messageOriginator
    }
}
