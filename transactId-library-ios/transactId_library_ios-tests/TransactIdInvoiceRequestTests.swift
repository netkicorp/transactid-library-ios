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
        let invoiceRequestParameters = InvoiceRequestParameters()
        invoiceRequestParameters.amount = 1000
        invoiceRequestParameters.memo = "memo"
        invoiceRequestParameters.notificationUrl = "notificationUrl"
        invoiceRequestParameters.originatorsAddresses = TestData.Outputs.outputs
        invoiceRequestParameters.originatorParameters = [TestData.Originators.primaryOriginatorPkiX509SHA256,
                                                         TestData.Originators.noPrimaryOriginatorPkiX509SHA256]
        invoiceRequestParameters.beneficiaryParameters = [TestData.Beneficiaries.primaryBeneficiaryParametersPkiNone]
        invoiceRequestParameters.senderParameters = TestData.Senders.senderPkiX509SHA256WithEncryption
        invoiceRequestParameters.attestationsRequested = TestData.Attestations.requestedAttestations
        invoiceRequestParameters.recipientParameters = TestData.Recipients.recipientsParametersWithEncryption
        invoiceRequestParameters.messageInformation = TestData.MessageInformationData.messageInformationEncryption
        
        if let invoiceRequest = try self.transactId.createInvoiceRequest(invoiceRequestParameters: invoiceRequestParameters) {
            let isInvoiceRequestValid = try self.transactId.isInvoiceRequestValid(invoiceRequestBinary: invoiceRequest, recipientParameters: TestData.Recipients.recipientsParametersWithEncryption)
            XCTAssert(isInvoiceRequestValid)
            
        } else {
            XCTFail("Failed to Create InvoiceRequestBinary")
        }
    }
    
    //MARK: Create and validate InvoiceRequestBinary Encrypted, Owners and Sender with PkiData without RecipientParametersEncryptionParameters
    
    func testCreateAndValidateInvoiceRequestBinaryEncryptedOwnersAndSenderWithPkiDataWithoutRecipientParametersEncryptionParameters() throws {
        let invoiceRequestParameters = InvoiceRequestParameters()
        invoiceRequestParameters.amount = 1000
        invoiceRequestParameters.memo = "memo"
        invoiceRequestParameters.notificationUrl = "notificationUrl"
        invoiceRequestParameters.originatorsAddresses = TestData.Outputs.outputs
        invoiceRequestParameters.originatorParameters = [TestData.Originators.primaryOriginatorPkiX509SHA256,
                                                         TestData.Originators.noPrimaryOriginatorPkiX509SHA256]
        invoiceRequestParameters.beneficiaryParameters = [TestData.Beneficiaries.primaryBeneficiaryParametersPkiNone]
        invoiceRequestParameters.senderParameters = TestData.Senders.senderPkiX509SHA256WithEncryption
        invoiceRequestParameters.attestationsRequested = TestData.Attestations.requestedAttestations
        invoiceRequestParameters.recipientParameters = TestData.Recipients.recipientsParametersWithEncryption
        invoiceRequestParameters.messageInformation = TestData.MessageInformationData.messageInformationEncryption
        
        if let invoiceRequest = try self.transactId.createInvoiceRequest(invoiceRequestParameters: invoiceRequestParameters) {
            XCTAssertThrowsError(try self.transactId.isInvoiceRequestValid(invoiceRequestBinary: invoiceRequest)) { error in
                guard case Exception.EncryptionException(ExceptionMessages.decryptionMissingRecipientKeysError) = error else {
                    return XCTFail()
                }
            }
        } else {
            XCTFail("Failed to Create InvoiceRequestBinary")
        }
    }
    
    //MARK: Create and validate InvoiceRequestBinary encrypted, without sender's public and private key
    
    func testCreateAndValidateInvoiceRequestBinaryEncryptedWithoutSenderPublicAndPrivateKey() throws {
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
        invoiceRequestParameters.recipientParameters = TestData.Recipients.recipientsParametersWithEncryption
        invoiceRequestParameters.messageInformation = TestData.MessageInformationData.messageInformationEncryption
        
        XCTAssertThrowsError(try self.transactId.createInvoiceRequest(invoiceRequestParameters: invoiceRequestParameters)) { error in
            guard case Exception.EncryptionException(ExceptionMessages.encryptionMissingSenderKeysError) = error else {
                return XCTFail()
            }
        }
    }
    
    //MARK: Create and validate InvoiceRequestBinary encrypted, without recipient's public key
    
    func testCreateAndValidateInvoiceRequestBinaryEncryptedWithoutRecipientPublicKey() throws {
        let invoiceRequestParameters = InvoiceRequestParameters()
        invoiceRequestParameters.amount = 1000
        invoiceRequestParameters.memo = "memo"
        invoiceRequestParameters.notificationUrl = "notificationUrl"
        invoiceRequestParameters.originatorsAddresses = TestData.Outputs.outputs
        invoiceRequestParameters.originatorParameters = [TestData.Originators.primaryOriginatorPkiX509SHA256,
                                                         TestData.Originators.noPrimaryOriginatorPkiX509SHA256]
        invoiceRequestParameters.beneficiaryParameters = [TestData.Beneficiaries.primaryBeneficiaryParametersPkiNone]
        invoiceRequestParameters.senderParameters = TestData.Senders.senderPkiX509SHA256WithEncryption
        invoiceRequestParameters.attestationsRequested = TestData.Attestations.requestedAttestations
        invoiceRequestParameters.recipientParameters = TestData.Recipients.recipientsParameters
        invoiceRequestParameters.messageInformation = TestData.MessageInformationData.messageInformationEncryption
        
        XCTAssertThrowsError(try self.transactId.createInvoiceRequest(invoiceRequestParameters: invoiceRequestParameters)) { error in
            guard case Exception.EncryptionException(ExceptionMessages.encryptionMissingRecipientKeysError) = error else {
                return XCTFail()
            }
        }
    }
    
    //MARK: Create and parse InvoiceRequestBinary encrypted to InvoiceRequest
    
    func testCreateAndParseInvoiceRequestBinaryEncryptedToInvoiceRequest() throws {
        let sender = TestData.Senders.senderPkiX509SHA256WithEncryption
        
        let invoiceRequestParameters = InvoiceRequestParameters()
        invoiceRequestParameters.amount = 1000
        invoiceRequestParameters.memo = "memo"
        invoiceRequestParameters.notificationUrl = "notificationUrl"
        invoiceRequestParameters.originatorsAddresses = TestData.Outputs.outputs
        invoiceRequestParameters.originatorParameters = [TestData.Originators.primaryOriginatorPkiX509SHA256,
                                                         TestData.Originators.noPrimaryOriginatorPkiX509SHA256]
        invoiceRequestParameters.beneficiaryParameters = [TestData.Beneficiaries.primaryBeneficiaryParametersPkiX509SHA256]
        invoiceRequestParameters.senderParameters = sender
        invoiceRequestParameters.attestationsRequested = TestData.Attestations.requestedAttestations
        invoiceRequestParameters.recipientParameters = TestData.Recipients.recipientsParametersWithEncryption
        invoiceRequestParameters.messageInformation = TestData.MessageInformationData.messageInformationEncryption
        
        if let invoiceRequestBinary = try self.transactId.createInvoiceRequest(invoiceRequestParameters: invoiceRequestParameters) {
            if let invoiceRequest = try self.transactId.parseInvoiceRequest(invoiceRequestBinary: invoiceRequestBinary, recipientParameters: TestData.Recipients.recipientsParametersWithEncryption) {
                XCTAssert(invoiceRequestParameters.amount == invoiceRequest.amount)
                XCTAssert(invoiceRequestParameters.memo == invoiceRequest.memo)
                XCTAssert(invoiceRequestParameters.notificationUrl == invoiceRequest.notificationUrl)
                XCTAssert(TestData.Attestations.requestedAttestations.count == invoiceRequest.attestationsRequested.count)
                XCTAssert(TestData.Outputs.outputs.count == invoiceRequest.originatorsAddresses.count)
                
                XCTAssert(invoiceRequest.originators.count == 2)
                XCTAssert(invoiceRequest.beneficiaries.count == 1)
                
                for (originatorIndex, originator) in invoiceRequest.originators.enumerated() {
                    XCTAssert(originator.isPrimaryForTransaction == invoiceRequestParameters.originatorParameters![originatorIndex].isPrimaryForTransaction)
                    
                    for (pkiDataIndex, pkiData) in originator.pkiDataSets!.enumerated() {
                        let ownerPkiData = TestData.Originators.primaryOriginatorPkiX509SHA256.pkiDataParametersSets![pkiDataIndex]
                        
                        XCTAssert(pkiData.pkiType == ownerPkiData.type)
                        XCTAssert(pkiData.attestation == ownerPkiData.attestation)
                        XCTAssert(pkiData.certificate == ownerPkiData.certificatePem)
                        
                        if (originator.isPrimaryForTransaction) {
                            XCTAssert(!pkiData.signature.isEmpty)
                        } else {
                            XCTAssert(pkiData.signature.isEmpty)
                        }
                    }
                }
                
                XCTAssert(sender.pkiDataParameters?.type == invoiceRequest.senderPkiType)
                XCTAssert(sender.pkiDataParameters?.certificatePem == invoiceRequest.senderPkiData)
                XCTAssert(!invoiceRequest.senderSignature!.isEmpty)
                XCTAssert(!invoiceRequest.protocolMessageMetadata!.identifier!.isEmpty)
                XCTAssert(invoiceRequest.protocolMessageMetadata!.version == 1)
                XCTAssert(invoiceRequest.protocolMessageMetadata!.messageType == MessageType.invoiceRequest)
                XCTAssert(invoiceRequest.protocolMessageMetadata!.encrypted)
                XCTAssert(!invoiceRequest.protocolMessageMetadata!.encryptedMessage!.isEmpty)
                XCTAssert(!invoiceRequest.protocolMessageMetadata!.recipientPublicKeyPem!.isEmpty)
                XCTAssert(!invoiceRequest.protocolMessageMetadata!.senderPublicKeyPem!.isEmpty)
                XCTAssert(!invoiceRequest.protocolMessageMetadata!.signature!.isEmpty)
                XCTAssert(invoiceRequest.protocolMessageMetadata!.nonce! > 0)
                
            } else {
                XCTFail("Failed to Parse InvoiceRequestBinary to InvoiceRequest")
            }
        } else {
            XCTFail("Failed to Create InvoiceRequestBinary")
        }
    }
    
    //MARK: Create and parse InvoiceRequestBinary to InvoiceRequest
    
    func testCreateAndParseInvoiceRequestBinaryToInvoiceRequest() throws {
        
        let sender = TestData.Senders.senderPkiX509SHA256
        
        let invoiceRequestParameters = InvoiceRequestParameters()
        invoiceRequestParameters.amount = 1000
        invoiceRequestParameters.memo = "memo"
        invoiceRequestParameters.notificationUrl = "notificationUrl"
        invoiceRequestParameters.originatorsAddresses = TestData.Outputs.outputs
        invoiceRequestParameters.originatorParameters = [TestData.Originators.primaryOriginatorPkiX509SHA256,
                                                         TestData.Originators.noPrimaryOriginatorPkiX509SHA256]
        invoiceRequestParameters.beneficiaryParameters = [TestData.Beneficiaries.primaryBeneficiaryParametersPkiX509SHA256]
        invoiceRequestParameters.senderParameters = sender
        invoiceRequestParameters.attestationsRequested = TestData.Attestations.requestedAttestations
        
        if let invoiceRequestBinary = try self.transactId.createInvoiceRequest(invoiceRequestParameters: invoiceRequestParameters) {
            if let invoiceRequest = try self.transactId.parseInvoiceRequest(invoiceRequestBinary: invoiceRequestBinary) {
                XCTAssert(invoiceRequestParameters.amount == invoiceRequest.amount)
                XCTAssert(invoiceRequestParameters.memo == invoiceRequest.memo)
                XCTAssert(invoiceRequestParameters.notificationUrl == invoiceRequest.notificationUrl)
                XCTAssert(TestData.Attestations.requestedAttestations.count == invoiceRequest.attestationsRequested.count)
                XCTAssert(TestData.Outputs.outputs.count == invoiceRequest.originatorsAddresses.count)
                
                XCTAssert(invoiceRequest.originators.count == 2)
                XCTAssert(invoiceRequest.beneficiaries.count == 1)
                
                for (originatorIndex, originator) in invoiceRequest.originators.enumerated() {
                    XCTAssert(originator.isPrimaryForTransaction == invoiceRequestParameters.originatorParameters![originatorIndex].isPrimaryForTransaction)
                    
                    for (pkiDataIndex, pkiData) in originator.pkiDataSets!.enumerated() {
                        let ownerPkiData = TestData.Originators.primaryOriginatorPkiX509SHA256.pkiDataParametersSets![pkiDataIndex]
                        
                        XCTAssert(pkiData.pkiType == ownerPkiData.type)
                        XCTAssert(pkiData.attestation == ownerPkiData.attestation)
                        XCTAssert(pkiData.certificate == ownerPkiData.certificatePem)
                        
                        if (originator.isPrimaryForTransaction) {
                            XCTAssert(!pkiData.signature.isEmpty)
                        } else {
                            XCTAssert(pkiData.signature.isEmpty)
                        }
                    }
                }
                
                XCTAssert(sender.pkiDataParameters?.type == invoiceRequest.senderPkiType)
                XCTAssert(sender.pkiDataParameters?.certificatePem == invoiceRequest.senderPkiData)
                XCTAssert(!invoiceRequest.senderSignature!.isEmpty)
                XCTAssert(!invoiceRequest.protocolMessageMetadata!.identifier!.isEmpty)
                XCTAssert(invoiceRequest.protocolMessageMetadata!.version == 1)
                XCTAssert(invoiceRequest.protocolMessageMetadata!.messageType == MessageType.invoiceRequest)
                XCTAssert(invoiceRequest.protocolMessageMetadata!.statusCode == StatusCode.ok)
                XCTAssert(invoiceRequest.protocolMessageMetadata!.statusMessage!.isEmpty)
                XCTAssert(!invoiceRequest.senderEvCert!.isEmpty)
                
            } else {
                XCTFail("Failed to Parse InvoiceRequestBinary to InvoiceRequest")
            }
        } else {
            XCTFail("Failed to Create InvoiceRequestBinary")
        }
    }
    
    //MARK: Create and parse InvoiceRequestBinary to InvoiceRequest with message information
    
    func testCreateAndParseInvoiceRequestBinaryToInvoiceRequestWithMessageInformation() throws {
        let sender = TestData.Senders.senderPkiX509SHA256
        
        let invoiceRequestParameters = InvoiceRequestParameters()
        invoiceRequestParameters.amount = 1000
        invoiceRequestParameters.memo = "memo"
        invoiceRequestParameters.notificationUrl = "notificationUrl"
        invoiceRequestParameters.originatorsAddresses = TestData.Outputs.outputs
        invoiceRequestParameters.originatorParameters = [TestData.Originators.primaryOriginatorPkiX509SHA256,
                                                         TestData.Originators.noPrimaryOriginatorPkiX509SHA256]
        invoiceRequestParameters.beneficiaryParameters = []
        invoiceRequestParameters.senderParameters = sender
        invoiceRequestParameters.attestationsRequested = TestData.Attestations.requestedAttestations
        invoiceRequestParameters.messageInformation = TestData.MessageInformationData.messageInformationCancel
        
        
        if let invoiceRequestBinary = try self.transactId.createInvoiceRequest(invoiceRequestParameters: invoiceRequestParameters) {
            if let invoiceRequest = try self.transactId.parseInvoiceRequest(invoiceRequestBinary: invoiceRequestBinary) {
                XCTAssert(invoiceRequestParameters.amount == invoiceRequest.amount)
                XCTAssert(invoiceRequestParameters.memo == invoiceRequest.memo)
                XCTAssert(invoiceRequestParameters.notificationUrl == invoiceRequest.notificationUrl)
                XCTAssert(TestData.Attestations.requestedAttestations.count == invoiceRequest.attestationsRequested.count)
                XCTAssert(TestData.Outputs.outputs.count == invoiceRequest.originatorsAddresses.count)
                
                XCTAssert(invoiceRequest.originators.count == 2)
                XCTAssert(invoiceRequest.beneficiaries.count == 0)
                
                for (originatorIndex, originator) in invoiceRequest.originators.enumerated() {
                    XCTAssert(originator.isPrimaryForTransaction == invoiceRequestParameters.originatorParameters![originatorIndex].isPrimaryForTransaction)
                    
                    for (pkiDataIndex, pkiData) in originator.pkiDataSets!.enumerated() {
                        let ownerPkiData = TestData.Originators.primaryOriginatorPkiX509SHA256.pkiDataParametersSets![pkiDataIndex]
                        
                        XCTAssert(pkiData.pkiType == ownerPkiData.type)
                        XCTAssert(pkiData.attestation == ownerPkiData.attestation)
                        XCTAssert(pkiData.certificate == ownerPkiData.certificatePem)
                        
                        if (originator.isPrimaryForTransaction) {
                            XCTAssert(!pkiData.signature.isEmpty)
                        } else {
                            XCTAssert(pkiData.signature.isEmpty)
                        }
                    }
                }
                
                XCTAssert(sender.pkiDataParameters?.type == invoiceRequest.senderPkiType)
                XCTAssert(sender.pkiDataParameters?.certificatePem == invoiceRequest.senderPkiData)
                XCTAssert(!invoiceRequest.senderSignature!.isEmpty)
                XCTAssert(!invoiceRequest.protocolMessageMetadata!.identifier!.isEmpty)
                XCTAssert(invoiceRequest.protocolMessageMetadata!.version == 1)
                XCTAssert(invoiceRequest.protocolMessageMetadata!.messageType == MessageType.invoiceRequest)
                XCTAssert(invoiceRequest.protocolMessageMetadata!.statusCode == StatusCode.cancel)
                XCTAssert(invoiceRequest.protocolMessageMetadata!.statusMessage == TestData.MessageInformationData.messageInformationCancel.statusMessage)
                XCTAssert(!invoiceRequest.protocolMessageMetadata!.encrypted)
                
            } else {
                XCTFail("Failed to Parse InvoiceRequestBinary to InvoiceRequest")
            }
        } else {
            XCTFail("Failed to Create InvoiceRequestBinary")
        }
    }
    
    //MARK: Validate invalid InvoiceRequestBinary
    
    func testValidateInvalidInvoiceRequestBinary() throws {
        XCTAssertThrowsError(try self.transactId.isInvoiceRequestValid(invoiceRequestBinary: "fakeInvoiceRequest".data(using: .utf8)!)) { error in
            guard case Exception.InvalidObjectException("Invalid object for message, error: The operation couldn’t be completed. (SwiftProtobuf.BinaryDecodingError error 3.)") = error else {
                return XCTFail()
            }
        }
    }
    
}
