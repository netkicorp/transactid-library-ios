//
//  Token.swift
//  transactId-library-ios
//
//  Created by Developer on 08.02.2021.
//

import Foundation

class Token {
    var accessToken: String?
    var refreshToken: String?
    
    init(accessToken: String, refreshToken: String) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
    }
    
    init(networkModel: TokenResponse) {
        self.accessToken = networkModel.accessToken
        self.refreshToken = networkModel.refreshToken
    }
    
    func bearer() -> String? {
        if let at = self.accessToken {
            return "Bearer \(at)"
        }
        return nil
    }
}
