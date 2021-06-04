//
//  AddressInformationServiceNetki.swift
//  transactId-library-ios
//
//  Created by Developer on 24.03.2021.
//

import Foundation

class AddressInformationServiceNetki: AddressInformationService {
    
    private let addressInformationRepo: AddressInformationRepo
    
    init(addressInformationRepo: AddressInformationRepo) {
        self.addressInformationRepo = addressInformationRepo
    }
    
    func getAddressInformation(currency: AddressCurrency, address: String) throws -> AddressInformation? {
        return try self.addressInformationRepo.getAddressInformation(currency: currency, address: address)
    }
    
    
}
