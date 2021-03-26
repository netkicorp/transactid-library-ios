//
//  AddressInformaionServiceNetki.swift
//  transactId-library-ios
//
//  Created by Developer on 24.03.2021.
//

import Foundation

class AddressInformaionServiceNetki: AddressInformationService {
    
    private let addressInformationRepo: AddressInformationRepo
    
    init(addressInformationRepo: AddressInformationRepo) {
        self.addressInformationRepo = addressInformationRepo
    }
    
    func getAddressInformation(currency: AddressCurrency, address: String) -> AddressInformation {
        return self.addressInformationRepo.getAddressInformation(currency: currency, address: address)
    }
    
    
}
