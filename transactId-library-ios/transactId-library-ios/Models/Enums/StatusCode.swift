//
//  StatusCode.swift
//  transactId-library-ios
//
//  Created by Developer on 09.02.2021.
//

import Foundation

/**
 * Message Protocol Status Code.
 */
public enum StatusCode: Int {
    
    case ok = 1
    case cancel = 2
    case generalUnknownError = 100
    case versionTooHigh = 101
    case authenticationFailed = 102
    case encryptionMessageRequired = 103
    case amountTooHigh = 200
    case amountTooLow = 201
    case amountInvalid = 202
    case paymentDoesNotMeetPaymentRequestRequirements = 203
    case certificateRequired = 300
    case certificateExpired = 301
    
}
