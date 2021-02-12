//
//  Response.swift
//  transactId-library-ios
//
//  Created by Developer on 08.02.2021.
//

import Foundation

enum ResponseError: Error {
    case invalidResponse
}

protocol Response {
    
    static func fromJSONResponse(value: Any) -> Response?
    
}

