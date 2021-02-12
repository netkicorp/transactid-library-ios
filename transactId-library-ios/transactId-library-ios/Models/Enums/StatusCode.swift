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
enum StatusCode: Int {
    
    case OK = 1
    case CANCEL = 2
    case GENERAL_UNKNOWN_ERROR = 100
    case VERSION_TOO_HIGH = 101
    case AUTHENTICATION_FAILED = 102
    case ENCRYPTED_MESSAGE_REQUIRED = 103
    case AMOUNT_TOO_HIGH = 200
    case AMOUNT_TOO_LOW = 201
    case AMOUNT_INVALID = 202
    case PAYMENT_DOES_NOT_MEET_PAYMENT_REQUEST_REQUIREMENTS = 203
    case CERTIFICATE_REQUIRED = 300
    case CERTIFICATE_EXPIRED = 301
    
}
