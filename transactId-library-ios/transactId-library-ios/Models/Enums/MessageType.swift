//
//  MessageType.swift
//  transactId-library-ios
//
//  Created by Developer on 01.03.2021.
//

import Foundation

public enum  MessageType : Int {

    case unknownMessageType
    case invoiceRequest
    case paymentRequest
    case payment
    case paymentACK
    
}
