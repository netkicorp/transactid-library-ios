//
//  MerkleRepo.swift
//  transactId-library-ios
//
//  Created by Developer on 17.05.2021.
//

import Foundation

/**
 * Implementation to fetch the address information from Merkle provider.
 */

private let xApiKeyHeader = "X-API-KEY"
private let identifierParameter = "identifier"
private let currencyParameter = "currency"
private let merkleBaseUrl = "https://api.merklescience.com/"
private let addressInfoPath = "api/v3/addresses/"

public class MerkleRepo : AddressInformationRepo {
    
    private let authorizationKey: String
    
    public init(authorizationKey: String) {
        self.authorizationKey = authorizationKey
    }
    
    public func getAddressInformation(currency: AddressCurrency, address: String) throws -> AddressInformation? {
        
        var addressInformation: AddressInformation? = nil
        
        if let url = URL(string: "\(merkleBaseUrl)\(addressInfoPath)") {
            let semaphore = DispatchSemaphore(value: 0)
            
            var request = URLRequest(url: url)
            request.setValue(authorizationKey, forHTTPHeaderField: xApiKeyHeader)
            request.httpMethod = "POST"
            
            let parameters = [identifierParameter: address,
                              currencyParameter: currency.rawValue] as [String : Any]
            
            request.httpBody = parameters.percentEncoded()
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data else {
                    semaphore.signal()
                    return
                }
                
                let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                if let responseJSON = responseJSON as? [String: Any] {
                    addressInformation = MerkleAddress(json: responseJSON).toAddressInformation()
                }
                semaphore.signal()
            }
            
            task.resume()
            _ = semaphore.wait(timeout: DispatchTime.distantFuture)
            
        }
        return addressInformation
    }
}
