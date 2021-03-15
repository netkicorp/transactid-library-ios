//
//  TokenResponse.swift
//  transactId-library-ios
//
//  Created by Developer on 08.02.2021.
//

import Foundation
import SwiftyJSON

class TokenResponse: Response {

    let accessToken: String
    let refreshToken: String
    
    private init(accessToken: String?, refreshToken: String?) throws {
        if let at = accessToken, let rt = refreshToken {
            self.accessToken = at
            self.refreshToken = rt
        } else {
            throw ResponseError.invalidResponse
        }
    }

}

extension TokenResponse {

    static func fromJSONResponse(value: Any) -> Response? {
        let jsonDict = JSON(value).dictionary
        
        do {
            return try TokenResponse(accessToken: jsonDict?["access"]?.string, refreshToken: jsonDict?["refresh"]?.string)
        } catch  {
            return nil
        }
    }

}
