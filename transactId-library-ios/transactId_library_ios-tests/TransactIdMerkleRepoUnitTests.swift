//
//  TransactIdMerkleRepoUnitTests.swift
//  transactId_library_ios-tests
//
//  Created by Developer on 19.05.2021.
//

import Foundation

import XCTest
import transactId_library_ios

class TransactIdMerkleRepoUnitTests: XCTestCase {

    private let xApiKeyHeader = "X-API-KEY"
    private let identifierParameter = "identifier"
    private let currencyParameter = "currency"
    private let merkleBaseUrl = "https://api.merklescience.com/"
    private let addressInfoPath = "api/v3/addresses/"

    
    //MARK: Create and validate PaymentAckBinary
    
    func testCreateAndValidatePaymentAckBinary() throws {
        
        let merkleRepo = MerkleRepo(authorizationKey: "7WJNVNED7FZVZ09LXH4NGZV2ZPTKFLVNI9Y4CZOLWS")
        
        let addressInfo = try merkleRepo.getAddressInformation(currency: AddressCurrency.bitcoin, address: "367f4YWz1VCFaqBqwbTrzwi2b1h2U3w1AF")
        

    }

}
