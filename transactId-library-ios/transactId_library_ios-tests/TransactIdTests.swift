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
        
        let originatorsAddresses = TestData.Outputs.outputs
        let beneficiaryParameters = [TestData.Beneficiaries.primaryBeneficiaryParametersPkiNone]
        let senderParameters = TestData.Senders.senderPkiX509SHA256
        let attestationsRequested = TestData.Attestations.requestedAttestations
        
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
        
        if invoiceRequestBinary != nil {
            let result = try self.transactId.isInvoiceRequestValid(invoiceRequestBinary: invoiceRequestBinary!)
            let invoiceRequest = try self.transactId.parseInvoiceRequest(invoiceRequestBinary: invoiceRequestBinary!)
        }
    
    }
    
    func testCreateInvoiceRequestEncrypted() throws {
        let originatorParameters = [TestData.Originators.PRIMARY_ORIGINATOR_PKI_X509SHA256,
                                    TestData.Originators.NO_PRIMARY_ORIGINATOR_PKI_X509SHA256]
        
        let originatorsAddresses = TestData.Outputs.outputs
        
        let beneficiaryParameters = [TestData.Beneficiaries.primaryBeneficiaryParametersPkiNone]
        
        let senderParameters = TestData.Senders.senderPkiX509SHA256WithEncryption
        
        let attestationsRequested = TestData.Attestations.requestedAttestations
        
        let recipientParameters = TestData.Recipients.recipientsParametersWithEncryption
        
        let messageInformation = MessageInformation()
        messageInformation.encryptMessage = true
        
        let invoiceRequestParameters = InvoiceRequestParameters()
        invoiceRequestParameters.amount = 1000
        invoiceRequestParameters.memo = "memo"
        invoiceRequestParameters.notificationUrl = "notificationUrl"
        invoiceRequestParameters.originatorsAddresses = originatorsAddresses
        invoiceRequestParameters.originatorParameters = originatorParameters
        invoiceRequestParameters.beneficiaryParameters = beneficiaryParameters
        invoiceRequestParameters.senderParameters = senderParameters
        invoiceRequestParameters.attestationsRequested = attestationsRequested
        invoiceRequestParameters.recipientParameters = recipientParameters
        invoiceRequestParameters.messageInformation = messageInformation
        
        let invoiceRequestBinary = try self.transactId.createInvoiceRequest(invoiceRequestParameters: invoiceRequestParameters)
        
        if invoiceRequestBinary != nil {
            let result = try self.transactId.isInvoiceRequestValid(invoiceRequestBinary: invoiceRequestBinary!, recipientParameters: recipientParameters)

            try self.transactId.parseInvoiceRequest(invoiceRequestBinary: invoiceRequestBinary!, recipientParameters: recipientParameters)
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
