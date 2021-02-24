//
//  TransactIdTests.swift
//  transactId_library_ios-tests
//
//  Created by Developer on 24.02.2021.
//

import Foundation
import XCTest
import transactId_library_ios

class TransactIdTests: XCTestCase {
    
    private let transactId = TransactId(trustStore: nil)

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCreateInvoiceRequest() throws {
        let originatorParameters = [TestData.Originators.PRIMARY_ORIGINATOR_PKI_X509SHA256,
                                    TestData.Originators.NO_PRIMARY_ORIGINATOR_PKI_X509SHA256]
        
        let originatorsAddresses = TestData.Outputs.OUTPUTS
        let beneficiaryParameters = [TestData.Beneficiaries.PRIMARY_BENEFICIARY_PKI_NONE]
        let senderParameters = TestData.Senders.SENDER_PKI_X509SHA256
        let attestationsRequested = TestData.Attestations.REQUESTED_ATTESTATIONS
        
        let invoiceRequestParameters = InvoiceRequestParameters()
        invoiceRequestParameters.amount = 1000
        invoiceRequestParameters.memo = "memo"
        invoiceRequestParameters.notificationUrl = "notificationUrl"
        invoiceRequestParameters.originatorsAddresses = originatorsAddresses
        invoiceRequestParameters.originatorParameters = originatorParameters
        invoiceRequestParameters.beneficiaryParameters = beneficiaryParameters
        invoiceRequestParameters.senderParameters = senderParameters
        invoiceRequestParameters.attestationsRequested = attestationsRequested
        
        let invoiceRequestBinary = try self.transactId.createInvoiceRequest(invoiceRequestParameters: invoiceRequestParameters)
    
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
