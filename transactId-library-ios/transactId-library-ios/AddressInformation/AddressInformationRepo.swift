//
//  AddressInformationRepo.swift
//  transactId-library-ios
//
//  Created by Developer on 24.03.2021.
//

import Foundation

protocol AddressInformationRepo {
    
    /**
     * Fetch the information of a given address.
     *
     * @param currency of the address.
     * @param address to fetch the information.
     * @throws AddressProviderErrorException if there is an error fetching the information from the provider.
     * @throws AddressProviderUnauthorizedException if there is an error with the authorization to connect to the provider.
     * @return information of the address.
     */
    
    func getAddressInformation(currency: AddressCurrency, address: String) throws -> AddressInformation?

    
}
