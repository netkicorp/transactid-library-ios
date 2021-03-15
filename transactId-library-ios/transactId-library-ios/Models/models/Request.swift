//
//  Request.swift
//  transactId-library-ios
//
//  Created by Developer on 08.02.2021.
//

import Foundation

protocol Request {
    
    func toDict() -> [String: Any]
    
}
