//
//  ProtocolMessageType.swift
//  transactId-library-ios
//
//  Created by Developer on 01.03.2021.
//

import Foundation
import SwiftProtobuf

enum ProtocolMessageType: SwiftProtobuf.Enum {
    
    typealias RawValue = Int
    case unknownMessageType
    case invoiceRequest
    case paymentRequest
    case payment
    case paymentACK
    
    init() {
        self = .unknownMessageType
    }
    
    init?(rawValue: Int) {
        switch rawValue {
        case 0:
            self = .unknownMessageType
        case 1:
            self = .invoiceRequest
        case 2:
            self = .paymentRequest
        case 3:
            self = .payment
        case 4:
            self = .paymentACK
        default:
            return nil
        }
    }
    
    var rawValue: Int {
        switch self {
        case .unknownMessageType:
            return 0
        case .invoiceRequest:
            return 1
        case .paymentRequest:
            return 2
        case .payment:
            return 3
        case .paymentACK:
            return 4
        }
    }
    
}
