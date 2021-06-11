//
//  AddressInformationProvider.swift
//  transactId-library-ios
//
//  Created by Developer on 17.05.2021.
//

import Foundation

/**
 * Fetch the detailed information about an address.
 */
protocol AddressInformationProvider {
    
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
