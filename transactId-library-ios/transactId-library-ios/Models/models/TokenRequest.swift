//
//  TokenRequest.swift
//  transactId-library-ios
//
//  Created by Developer on 08.02.2021.
//

import Foundation

class TokenRequest: Request {
    let username: String
    let password: String
    
    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
}

extension TokenRequest {
    
    func toDict() -> [String: Any] {
        return ["username": self.username,
                "password": self.password]
    }

}
