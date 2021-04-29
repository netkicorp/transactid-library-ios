//
//  TransactIdInvoiceRequestTests.swift
//  transactId_library_ios-tests
//
//  Created by Developer on 20.04.2021.
//

import Foundation
import XCTest
import transactId_library_ios

class TransactIdInvoiceRequestTests: XCTestCase {
    
    private let transactId = TransactId(trustStore: nil)
    
    //MARK: Create and validate InvoiceRequestBinary, Owners and Sender with PkiData
    
    func testCreateAndValidateInvoiceRequestBinaryOwnersAndSenderWithPkiData() throws {
        
        let invoiceRequestParameters = InvoiceRequestParameters()
        invoiceRequestParameters.amount = 1000
        invoiceRequestParameters.memo = "memo"
        invoiceRequestParameters.notificationUrl = "notificationUrl"
        invoiceRequestParameters.originatorsAddresses = TestData.Outputs.outputs
        invoiceRequestParameters.originatorParameters = [TestData.Originators.primaryOriginatorPkiX509SHA256,
                                                         TestData.Originators.noPrimaryOriginatorPkiX509SHA256]
        invoiceRequestParameters.beneficiaryParameters = [TestData.Beneficiaries.primaryBeneficiaryParametersPkiNone]
        invoiceRequestParameters.senderParameters = TestData.Senders.senderPkiX509SHA256
        invoiceRequestParameters.attestationsRequested = TestData.Attestations.requestedAttestations
        
        if let invoiceRequest = try self.transactId.createInvoiceRequest(invoiceRequestParameters: invoiceRequestParameters) {
            let isInvoiceRequestValid = try self.transactId.isInvoiceRequestValid(invoiceRequestBinary: invoiceRequest)
            XCTAssert(isInvoiceRequestValid)
        } else {
            XCTFail("Failed to Create InvoiceRequestBinary")
        }
    }
    
    //MARK: Create and validate InvoiceRequestBinary, Owner and Sender with PkiData and bundle certificate
    
    func testCreateAndValidateInvoiceRequestBinaryOwnerAndSenderWithPkiDataAndBundleCertificate() throws {
        
        let invoiceRequestParameters = InvoiceRequestParameters()
        invoiceRequestParameters.amount = 1000
        invoiceRequestParameters.memo = "memo"
        invoiceRequestParameters.notificationUrl = "notificationUrl"
        invoiceRequestParameters.originatorsAddresses = TestData.Outputs.outputs
        invoiceRequestParameters.originatorParameters = [TestData.Originators.primaryOriginatorPkiX509SHA256BundledCertificate]
        invoiceRequestParameters.beneficiaryParameters = [TestData.Beneficiaries.primaryBeneficiaryParametersPkiNone]
        invoiceRequestParameters.senderParameters = TestData.Senders.senderPkiX509SHA256
        invoiceRequestParameters.attestationsRequested = TestData.Attestations.requestedAttestations
        
        if let invoiceRequest = try self.transactId.createInvoiceRequest(invoiceRequestParameters: invoiceRequestParameters) {
            let isInvoiceRequestValid = try self.transactId.isInvoiceRequestValid(invoiceRequestBinary: invoiceRequest)
            XCTAssert(isInvoiceRequestValid)
        } else {
            XCTFail("Failed to Create InvoiceRequestBinary")
        }
    }
    
    //MARK: Create and validate InvoiceRequestBinary, Owners and Sender with PkiData and bundle certificate
    
    func testCreateAndValidateInvoiceRequestBinaryOwnersAndSenderWithPkiDataAndBundleCertificate() throws {
        let invoiceRequestParameters = InvoiceRequestParameters()
        invoiceRequestParameters.amount = 1000
        invoiceRequestParameters.memo = "memo"
        invoiceRequestParameters.notificationUrl = "notificationUrl"
        invoiceRequestParameters.originatorsAddresses = TestData.Outputs.outputs
        invoiceRequestParameters.originatorParameters = [TestData.Originators.primaryOriginatorPkiX509SHA256,
                                                         TestData.Originators.noPrimaryOriginatorPkiX509SHA256]
        invoiceRequestParameters.beneficiaryParameters = [TestData.Beneficiaries.primaryBeneficiaryParametersPkiX509SHA256]
        invoiceRequestParameters.senderParameters = TestData.Senders.senderPkiX509SHA256
        invoiceRequestParameters.attestationsRequested = TestData.Attestations.requestedAttestations
        
        if let invoiceRequest = try self.transactId.createInvoiceRequest(invoiceRequestParameters: invoiceRequestParameters) {
            let isInvoiceRequestValid = try self.transactId.isInvoiceRequestValid(invoiceRequestBinary: invoiceRequest)
            XCTAssert(isInvoiceRequestValid)
        } else {
            XCTFail("Failed to Create InvoiceRequestBinary")
        }
    }

    //MARK: Create and validate InvoiceRequestBinary, Owners and Sender without PkiData
    
    func testCreateAndValidateInvoiceRequestBinaryOwnersAndSenderWithoutPkiData() throws {
        let invoiceRequestParameters = InvoiceRequestParameters()
        invoiceRequestParameters.amount = 1000
        invoiceRequestParameters.memo = "memo"
        invoiceRequestParameters.notificationUrl = "notificationUrl"
        invoiceRequestParameters.originatorsAddresses = TestData.Outputs.outputs
        invoiceRequestParameters.originatorParameters = [TestData.Originators.primaryOriginatorPkiNone,
                                                         TestData.Originators.noPrimaryOriginatorPkiNone]
        invoiceRequestParameters.beneficiaryParameters = [TestData.Beneficiaries.primaryBeneficiaryParametersPkiX509SHA256]
        invoiceRequestParameters.senderParameters = TestData.Senders.senderPkiNone
        invoiceRequestParameters.attestationsRequested = TestData.Attestations.requestedAttestations
        
        if let invoiceRequest = try self.transactId.createInvoiceRequest(invoiceRequestParameters: invoiceRequestParameters) {
            let isInvoiceRequestValid = try self.transactId.isInvoiceRequestValid(invoiceRequestBinary: invoiceRequest)
            XCTAssert(isInvoiceRequestValid)
        } else {
            XCTFail("Failed to Create InvoiceRequestBinary")
        }
    }
    
    //MARK: Create and validate InvoiceRequestBinary, Owners with PkiData and Sender without PkiData
    
    func testCreateAndValidateInvoiceRequestBinaryOwnersWithPkiDataAndSenderWithoutPkiData() throws {
        let invoiceRequestParameters = InvoiceRequestParameters()
        invoiceRequestParameters.amount = 1000
        invoiceRequestParameters.memo = "memo"
        invoiceRequestParameters.notificationUrl = "notificationUrl"
        invoiceRequestParameters.originatorsAddresses = TestData.Outputs.outputs
        invoiceRequestParameters.originatorParameters = [TestData.Originators.primaryOriginatorPkiX509SHA256,
                                                         TestData.Originators.noPrimaryOriginatorPkiX509SHA256]
        invoiceRequestParameters.beneficiaryParameters = [TestData.Beneficiaries.primaryBeneficiaryParametersPkiX509SHA256]
        invoiceRequestParameters.senderParameters = TestData.Senders.senderPkiNone
        invoiceRequestParameters.attestationsRequested = TestData.Attestations.requestedAttestations
        
        if let invoiceRequest = try self.transactId.createInvoiceRequest(invoiceRequestParameters: invoiceRequestParameters) {
            let isInvoiceRequestValid = try self.transactId.isInvoiceRequestValid(invoiceRequestBinary: invoiceRequest)
            XCTAssert(isInvoiceRequestValid)
        } else {
            XCTFail("Failed to Create InvoiceRequestBinary")
        }
    }
    
    //MARK: Create and validate InvoiceRequestBinary, Owners without PkiData and Sender with PkiData
    
    func testCreateAndValidateInvoiceRequestBinaryOwnersWithoutPkiDataAndSenderWithPkiData() throws {
        let invoiceRequestParameters = InvoiceRequestParameters()
        invoiceRequestParameters.amount = 1000
        invoiceRequestParameters.memo = "memo"
        invoiceRequestParameters.notificationUrl = "notificationUrl"
        invoiceRequestParameters.originatorsAddresses = TestData.Outputs.outputs
        invoiceRequestParameters.originatorParameters = [TestData.Originators.primaryOriginatorPkiNone,
                                                         TestData.Originators.noPrimaryOriginatorPkiNone]
        invoiceRequestParameters.senderParameters = TestData.Senders.senderPkiX509SHA256
        invoiceRequestParameters.attestationsRequested = TestData.Attestations.requestedAttestations
        
        if let invoiceRequest = try self.transactId.createInvoiceRequest(invoiceRequestParameters: invoiceRequestParameters) {
            let isInvoiceRequestValid = try self.transactId.isInvoiceRequestValid(invoiceRequestBinary: invoiceRequest)
            XCTAssert(isInvoiceRequestValid)
        } else {
            XCTFail("Failed to Create InvoiceRequestBinary")
        }
    }
    
    //MARK: Create and validate InvoiceRequestBinary, one Owner with PkiData, one Owner without data and Sender with PkiData
    
    func testCreateAndValidateInvoiceRequestBinaryOneOwnerWithPkiDataOneOwnerWithoutDataAndSenderWithPkiData() throws {
        let invoiceRequestParameters = InvoiceRequestParameters()
        invoiceRequestParameters.amount = 1000
        invoiceRequestParameters.memo = "memo"
        invoiceRequestParameters.notificationUrl = "notificationUrl"
        invoiceRequestParameters.originatorsAddresses = TestData.Outputs.outputs
        invoiceRequestParameters.originatorParameters = [TestData.Originators.primaryOriginatorPkiX509SHA256,
                                                         TestData.Originators.noPrimaryOriginatorPkiNone]
        invoiceRequestParameters.beneficiaryParameters = []
        invoiceRequestParameters.senderParameters = TestData.Senders.senderPkiX509SHA256
        invoiceRequestParameters.attestationsRequested = TestData.Attestations.requestedAttestations
        
        if let invoiceRequest = try self.transactId.createInvoiceRequest(invoiceRequestParameters: invoiceRequestParameters) {
            let isInvoiceRequestValid = try self.transactId.isInvoiceRequestValid(invoiceRequestBinary: invoiceRequest)
            XCTAssert(isInvoiceRequestValid)
        } else {
            XCTFail("Failed to Create InvoiceRequestBinary")
        }
    }
    
    //MARK: Create and validate InvoiceRequestBinary, Owners with PkiData and Sender with PkiData but invalid certificate chain
    
    func testCreateAndValidateInvoiceRequestBinaryOwnersWithPkiDataAndSenderWithPkiDataButInvalidCertificateChain() throws {
        let invoiceRequestParameters = InvoiceRequestParameters()
        invoiceRequestParameters.amount = 1000
        invoiceRequestParameters.memo = "memo"
        invoiceRequestParameters.notificationUrl = "notificationUrl"
        invoiceRequestParameters.originatorsAddresses = TestData.Outputs.outputs
        invoiceRequestParameters.originatorParameters = [TestData.Originators.primaryOriginatorPkiX509SHA256,
                                                         TestData.Originators.noPrimaryOriginatorPkiX509SHA256]
        invoiceRequestParameters.beneficiaryParameters = [TestData.Beneficiaries.primaryBeneficiaryParametersPkiX509SHA256]
        invoiceRequestParameters.senderParameters = TestData.Senders.senderPkiX509SHA256InvalidCertificate
        invoiceRequestParameters.attestationsRequested = TestData.Attestations.requestedAttestations
        
        if let invoiceRequest = try self.transactId.createInvoiceRequest(invoiceRequestParameters: invoiceRequestParameters) {
            XCTAssertThrowsError(try self.transactId.isInvoiceRequestValid(invoiceRequestBinary: invoiceRequest)) { error in
                guard case Exception.InvalidCertificateChainException(ExceptionMessages.certificateValidationInvalidSenderCertificateCA) = error else {
                    return XCTFail()
                }
            }
        } else {
            XCTFail("Failed to Create InvoiceRequestBinary")
        }
    }
    
    //MARK: Create and validate InvoiceRequestBinary, Owners with PkiData but invalid certificate chain and Sender with PkiData
    
    func testCreateAndValidateInvoiceRequestBinaryOwnersWithPkiDataButInvalidCertificateChainAndSenderWithPkiData() throws {
        let invoiceRequestParameters = InvoiceRequestParameters()
        invoiceRequestParameters.amount = 1000
        invoiceRequestParameters.memo = "memo"
        invoiceRequestParameters.notificationUrl = "notificationUrl"
        invoiceRequestParameters.originatorsAddresses = TestData.Outputs.outputs
        invoiceRequestParameters.originatorParameters = [TestData.Originators.primaryOriginatorPkiX509SHA256InvalidCertificate,
                                                         TestData.Originators.noPrimaryOriginatorPkiX509SHA256]
        invoiceRequestParameters.beneficiaryParameters = [TestData.Beneficiaries.primaryBeneficiaryParametersPkiX509SHA256]
        invoiceRequestParameters.senderParameters = TestData.Senders.senderPkiX509SHA256
        invoiceRequestParameters.attestationsRequested = TestData.Attestations.requestedAttestations
        
        if let invoiceRequest = try self.transactId.createInvoiceRequest(invoiceRequestParameters: invoiceRequestParameters) {
            XCTAssertThrowsError(try self.transactId.isInvoiceRequestValid(invoiceRequestBinary: invoiceRequest)) { error in
                guard case Exception.InvalidCertificateChainException(ExceptionMessages.certificateValidationInvalidSenderCertificateCA) = error else {
                    return XCTFail()
                }
            }
        } else {
            XCTFail("Failed to Create InvoiceRequestBinary")
        }
    }
    
    //MARK: Create and validate InvoiceRequestBinary Encrypted, Owners and Sender with PkiData
    
    func testCreateAndValidateInvoiceRequestBinaryEncryptedOwnersAndSenderWithPkiData() throws {
        
    }
    
    //MARK: Create and validate InvoiceRequestBinary Encrypted, Owners and Sender with PkiData without RecipientParametersEncryptionParameters
    
    func testCreateAndValidateInvoiceRequestBinaryEncryptedOwnersAndSenderWithPkiDataWithoutRecipientParametersEncryptionParameters() throws {
        
    }
    
    //MARK: Create and validate InvoiceRequestBinary encrypted, without sender's public and private key
    
    func testCreateAndValidateInvoiceRequestBinaryEncryptedWithoutSenderPublicAndPrivateKey() throws {
        
    }
    
    //MARK: Create and validate InvoiceRequestBinary encrypted, without recipient's public key
    
    func testCreateAndValidateInvoiceRequestBinaryEncryptedWithoutRecipientPublicKey() throws {
        
    }
    
    //MARK: Create and parse InvoiceRequestBinary encrypted to InvoiceRequest
    
    func testCreateAndParseInvoiceRequestBinaryEncryptedToInvoiceRequest() throws {
        
    }
    
    //MARK: Create and parse InvoiceRequestBinary to InvoiceRequest
    
    func testCreateAndParseInvoiceRequestBinaryToInvoiceRequest() throws {
        
    }
    
    //MARK: Create and parse InvoiceRequestBinary to InvoiceRequest with message information
    
    func testCreateAndParseInvoiceRequestBinaryToInvoiceRequestWithMessageInformation() throws {
        
    }
    
    //MARK: Validate invalid InvoiceRequestBinary
    
    func testValidateInvalidInvoiceRequestBinary() throws {
        
    }
    
}
