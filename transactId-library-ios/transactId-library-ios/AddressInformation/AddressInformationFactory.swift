//
//  AddressInformationFactory.swift
//  transactId-library-ios
//
//  Created by Developer on 17.05.2021.
//

import Foundation

/**
 * Factory to generate AddressInformation instance.
 */

class AddressInformationFactory {
    
    private static var sharedAddressInformationFactory = AddressInformationFactory()

    private init () {}
    
    class func shared() -> AddressInformationFactory {
        return sharedAddressInformationFactory
    }
    
    func getInstance(authorizationKey: String) -> AddressInformationProvider {
        
        let addressInformationRepo = MerkleRepo(authorizationKey: authorizationKey)
        let addressInformationServiceNetki = AddressInformationServiceNetki(addressInformationRepo: addressInformationRepo)
        return AddressInformationProviderNetki(addressInformationService: addressInformationServiceNetki)
    }
    
}
