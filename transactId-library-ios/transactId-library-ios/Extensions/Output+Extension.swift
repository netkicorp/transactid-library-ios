//
//  Output+Extension.swift
//  transactId-library-ios
//
//  Created by Developer on 25.02.2021.
//

import Foundation

extension Output {
    
    func toMessageOutput() -> MessageOutput {
        var messageOutput = MessageOutput()
        messageOutput.amount = UInt64(self.amount)
        messageOutput.currency = UInt64(self.currency.rawValue)
        messageOutput.script = self.script?.data(using: .utf8) ?? Data()
        return messageOutput
    }
}
