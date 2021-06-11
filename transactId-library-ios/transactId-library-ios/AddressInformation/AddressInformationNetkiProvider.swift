//
//  AddressInformationProviderNetki.swift
//  transactId-library-ios
//
//  Created by Developer on 17.05.2021.
//

import Foundation

class AddressInformationProviderNetki: AddressInformationProvider {
    
    private let addressInformationService: AddressInformationService
    
    init(addressInformationService: AddressInformationService) {
        self.addressInformationService = addressInformationService
    }
    
    func getAddressInformation(currency: AddressCurrency, address: String) throws -> AddressInformation? {
        return try self.addressInformationService.getAddressInformation(currency: currency, address: address)
    }
    
}
