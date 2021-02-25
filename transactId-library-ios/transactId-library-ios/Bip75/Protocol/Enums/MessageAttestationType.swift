//
//  MessageAttestationType.swift
//  transactId-library-ios
//
//  Created by Developer on 25.02.2021.
//

import Foundation
import SwiftProtobuf

enum MessageAttestationType: SwiftProtobuf.Enum {
    
    typealias RawValue = Int
    case legalPersonPrimaryName
    case legalPersonSecondaryName
    case addressDepartament
    case addressSubDepartament
    case addressStreetName
    case addressBuildingNumber
    case addressBuildingName
    case addressFloor
    case addressPostbox
    case addressRoom
    case addressPostcode
    case addressTownName
    case addressTownLocationName
    case addressDistinctName
    case addressCountrySubDivision
    case addressAddresLine
    case addressCountry
    case naturalPersonFirstName
    case naturalPersonLastName
    case beneficiaryPersonFirstName
    case beneficiaryPersonLastName
    case birthDate
    case birthPlace
    case countryOfResidence
    case issuingCountry
    case nationalIdentifierNumber
    case nationalIdentifier
    case accountNumber
    case consumerIdentification
    case registrationAuthority
    
    init() {
        self = .legalPersonPrimaryName
    }
    
    init?(rawValue: Int) {
        switch rawValue {
        case 0:
            self = .legalPersonPrimaryName
        case 1:
            self = .legalPersonSecondaryName
        case 2:
            self = .addressDepartament
        case 3:
            self = .addressSubDepartament
        case 4:
            self = .addressStreetName
        case 5:
            self = .addressBuildingNumber
        case 6:
            self = .addressBuildingName
        case 7:
            self = .addressFloor
        case 8:
            self = .addressPostbox
        case 9:
            self = .addressRoom
        case 10:
            self = .addressPostcode
        case 11:
            self = .addressTownName
        case 12:
            self = .addressTownLocationName
        case 13:
            self = .addressDistinctName
        case 14:
            self = .addressCountrySubDivision
        case 15:
            self = .addressAddresLine
        case 16:
            self = .addressCountry
        case 17:
            self = .naturalPersonFirstName
        case 18:
            self = .naturalPersonLastName
        case 19:
            self = .beneficiaryPersonFirstName
        case 20:
            self = .beneficiaryPersonLastName
        case 21:
            self = .birthDate
        case 22:
            self = .birthPlace
        case 23:
            self = .countryOfResidence
        case 24:
            self = .issuingCountry
        case 25:
            self = .nationalIdentifierNumber
        case 26:
            self = .nationalIdentifier
        case 27:
            self = .accountNumber
        case 28:
            self = .consumerIdentification
        case 29:
            self = .registrationAuthority
        default:
            return nil
        }
    }
    
    var rawValue: Int {
        switch self {
        case .legalPersonPrimaryName:
            return 0
        case .legalPersonSecondaryName:
            return 1
        case .addressDepartament:
            return 2
        case .addressSubDepartament:
            return 3
        case .addressStreetName:
            return 4
        case .addressBuildingNumber:
            return 5
        case .addressBuildingName:
            return 6
        case .addressFloor:
            return 7
        case .addressPostbox:
            return 8
        case .addressRoom:
            return 9
        case .addressPostcode:
            return 10
        case .addressTownName:
            return 11
        case .addressTownLocationName:
            return 12
        case .addressDistinctName:
            return 13
        case .addressCountrySubDivision:
            return 14
        case .addressAddresLine:
            return 15
        case .addressCountry:
            return 16
        case .naturalPersonFirstName:
            return 17
        case .naturalPersonLastName:
            return 18
        case .beneficiaryPersonFirstName:
            return 19
        case .beneficiaryPersonLastName:
            return 20
        case .birthDate:
            return 21
        case .birthPlace:
            return 22
        case .countryOfResidence:
            return 23
        case .issuingCountry:
            return 24
        case .nationalIdentifierNumber:
            return 25
        case .nationalIdentifier:
            return 26
        case .accountNumber:
            return 27
        case .consumerIdentification:
            return 28
        case .registrationAuthority:
            return 29
        }
    }
}
