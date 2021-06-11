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
    
    //MARK: Create and validate PaymentAckBinary
    
    func testCreateAndValidatePaymentAckBinary() throws {
        
        let merkleRepo = MerkleRepo(authorizationKey: "7WJNVNED7FZVZ09LXH4NGZV2ZPTKFLVNI9Y4CZOLWS")
        
        if let addressInformation = try merkleRepo.getAddressInformation(currency: AddressCurrency.bitcoin, address: "367f4YWz1VCFaqBqwbTrzwi2b1h2U3w1AF") {
                
            XCTAssert(addressInformation.identifier == "367f4YWz1VCFaqBqwbTrzwi2b1h2U3w1AF")
            XCTAssert(addressInformation.balance == 589.00293000001693)
            XCTAssert(addressInformation.currency == AddressCurrency.bitcoin.rawValue)
            XCTAssert(addressInformation.currencyVerbose == "Bitcoin")
            XCTAssert(addressInformation.riskLevel == 5)
            XCTAssert(addressInformation.riskLevelVerbose == "Critical")
            XCTAssert(addressInformation.totalIncomingValue == "396513.9406")
            XCTAssert(addressInformation.totalIncomingValueUsd == "5959999379.62")
            XCTAssert(addressInformation.totalOutgoingValue == "395924.9377")
            XCTAssert(addressInformation.totalOutgoingValueUsd == "5979830112.47")
            XCTAssert(addressInformation.tags?.user?.tagNameVerbose == nil)
            XCTAssert(addressInformation.tags?.user?.tagSubtypeVerbose == nil)
            XCTAssert(addressInformation.tags?.user?.tagTypeVerbose == nil)
            XCTAssert(addressInformation.tags?.user?.totalValueUsd == nil)
            XCTAssert(addressInformation.tags?.owner?.tagNameVerbose == "Gopax")
            XCTAssert(addressInformation.tags?.owner?.tagSubtypeVerbose == "Optional KYC and AML")
            XCTAssert(addressInformation.tags?.owner?.tagTypeVerbose == "Exchange")
            XCTAssert(addressInformation.tags?.owner?.totalValueUsd == nil)

        } else {
            XCTFail("Failed to Get Address Information")
        }

    }

}
