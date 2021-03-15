//
//  Attestation.swift
//  transactId-library-ios
//
//  Created by Developer on 02.02.2021.
//

import Foundation

public enum Attestation: Int {
    
    case legalPersonPrimaryName = 0
    case legalPersonSecondaryName = 1
    case addressDepartament = 2
    case addressSubDepartament = 3
    case addressStreetName = 4
    case addressBuildingNumber = 5
    case addressBuildingName = 6
    case addressFloor = 7
    case addressPostbox = 8
    case addressRoom = 9
    case addressPostcode = 10
    case addressTownName = 11
    case addressTownLocationName = 12
    case addressDistinctName = 13
    case addressCountrySubDivision = 14
    case addressAddresLine = 15
    case addressCountry = 16
    case naturalPersonFirstName = 17
    case naturalPersonLastName = 18
    case beneficiaryPersonFirstName = 19
    case beneficiaryPersonLastName = 20
    case birthDate = 21
    case birthPlace = 22
    case countryOfResidence = 23
    case issuingCountry = 24
    case nationalIdentifierNumber = 25
    case nationalIdentifier = 26
    case accountNumber = 27
    case consumerIdentification = 28
    case registrationAuthority = 29

}
