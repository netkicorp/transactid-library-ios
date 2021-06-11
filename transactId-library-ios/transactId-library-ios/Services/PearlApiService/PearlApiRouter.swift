//
//  PearlApiRouter.swift
//  transactId-library-ios
//
//  Created by Developer on 08.02.2021.
//

import Foundation
import Alamofire

enum PearlApiRouter: URLRequestConvertible {
    
    case getToken(parameters: Parameters)
    case createUser(parameters: Parameters, token: String)
    case getTransactions(parameters: Parameters, token: String)
    case generateCertificate(transactionID: String, token: String, parameters: Parameters)
    case generateCSR(transactionID: String, token: String, parameters: Parameters)
    case getCertificates(transactionID: String, token: String)
    
    private var method: HTTPMethod {
        switch self {
        case .getToken,
             .createUser,
             .generateCertificate,
             .generateCSR:
            return .post
        case .getTransactions,
             .getCertificates:
            return .get
        }
    }
    
    private var path: String {
        switch self {
        case .getToken:
            return "api/token-auth/"
        case .createUser:
            return "api/users/"
        case .getTransactions:
            return "api/account/transactions/"
        case .generateCertificate(let transactionID, _, _):
            return "/api/transactions/\(transactionID)/make-certificates/"
        case .generateCSR(let transactionID, _, _):
            return "/api/transactions/\(transactionID)/csrs/"
        case .getCertificates(let transactionID, _):
            return "/api/transactions/\(transactionID)/certificates/"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try SettingsProvider.pearlApiBaseURL.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        switch self {
        case .getToken(let parameters):
            urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
        case .createUser(let parameters, let token):
            urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
            urlRequest.setValue("Token \(token)", forHTTPHeaderField: "Authorization")
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
        case .getTransactions( _, let token):
            urlRequest.setValue(token, forHTTPHeaderField: "Authorization")
        case .generateCertificate( _, let token, let parameters):
            urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
            urlRequest.setValue(token, forHTTPHeaderField: "Authorization")
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
        case .generateCSR(_, let token, let parameters):
            urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
            urlRequest.setValue(token, forHTTPHeaderField: "Authorization")
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
        case .getCertificates(_, let token):
            urlRequest.setValue(token, forHTTPHeaderField: "Authorization")
        }

        return urlRequest
    }

}
