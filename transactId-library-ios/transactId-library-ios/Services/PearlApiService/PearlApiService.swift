//
//  PearlApiService.swift
//  transactId-library-ios
//
//  Created by Developer on 08.02.2021.
//

import Foundation
import Alamofire

class PearlApiService {
    
    private let session: Session = Session()
    
    init() {
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
    }
    
    func getToken(tokenRequest: TokenRequest, completion: @escaping (TokenResponse?, Error?) -> Void) {
        self.session.request(PearlApiRouter.getToken(parameters: tokenRequest.toDict())).responseJSON { (response) in
            if let error = response.error {
                completion(nil, error)
            } else  if let value = response.value {
                completion(TokenResponse.fromJSONResponse(value: value) as? TokenResponse, nil)
            }
        }
    }
    
    
}
