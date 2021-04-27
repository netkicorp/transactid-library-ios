//
//  TransactIdPaymentRequestTests.swift
//  transactId_library_ios-tests
//
//  Created by Developer on 20.04.2021.
//

import Foundation

import XCTest
import transactId_library_ios

class TransactIdPaymentRequestTests: XCTestCase {
    
    private let transactId = TransactId(trustStore: nil)
    
    //MARK: Create and validate PaymentRequestBinary, Owners and Sender with PkiData
    
    func testCreateAndValidatePaymentRequestBinaryOwnersAndSenderWithPkiData() throws {
        
        let paymentRequestParameters = PaymentRequestParameters()
        paymentRequestParameters.network = "main"
        paymentRequestParameters.beneficiariesAddresses = TestData.Outputs.outputs
        paymentRequestParameters.time = Date().timeIntervalSince1970
        paymentRequestParameters.expires = Date().timeIntervalSince1970
        paymentRequestParameters.memo = "memo"
        paymentRequestParameters.paymentUrl = "www.payment.url/test"
        paymentRequestParameters.merchantData = "merchantData"
        paymentRequestParameters.beneficiaryParameters = [TestData.Beneficiaries.primaryBeneficiaryParametersPkiX509SHA256,
                                                          TestData.Beneficiaries.noPrimaryBeneficiaryParametersPkiX509SHA256]
        
        paymentRequestParameters.senderParameters = TestData.Senders.senderPkiX509SHA256
        paymentRequestParameters.attestationsRequested = TestData.Attestations.requestedAttestations
        
        if let paymentRequestBinary = try self.transactId.createPaymentRequest(paymentRequestParameters: paymentRequestParameters) {
            let isPaymentRequestValid = try self.transactId.isPaymentRequestValid(paymentRequestBinary: paymentRequestBinary)
            XCTAssert(isPaymentRequestValid)
        } else {
            XCTFail("Failed to Create PaymentRequestBinary")
        }
    }
    
    //MARK: Create and validate PaymentRequestBinary, Owner and Sender with PkiData bundle
    
    func testCreateAndValidatePaymentRequestBinaryOwnersAndSenderWithPkiDataBundle() throws {
        let paymentRequestParameters = PaymentRequestParameters()
        paymentRequestParameters.network = "main"
        paymentRequestParameters.beneficiariesAddresses = TestData.Outputs.outputs
        paymentRequestParameters.time = Date().timeIntervalSince1970
        paymentRequestParameters.expires = Date().timeIntervalSince1970
        paymentRequestParameters.memo = "memo"
        paymentRequestParameters.paymentUrl = "www.payment.url/test"
        paymentRequestParameters.merchantData = "merchantData"
        paymentRequestParameters.beneficiaryParameters = [TestData.Beneficiaries.primaryBeneficiaryParametersPkiX509SHA256BundledCertificate,
                                                          TestData.Beneficiaries.noPrimaryBeneficiaryParametersPkiX509SHA256]
        
        paymentRequestParameters.senderParameters = TestData.Senders.senderPkiX509SHA256
        paymentRequestParameters.attestationsRequested = TestData.Attestations.requestedAttestations

        if let paymentRequestBinary = try self.transactId.createPaymentRequest(paymentRequestParameters: paymentRequestParameters) {
            let isPaymentRequestValid = try self.transactId.isPaymentRequestValid(paymentRequestBinary: paymentRequestBinary)
            XCTAssert(isPaymentRequestValid)
        } else {
            XCTFail("Failed to Create PaymentRequestBinary")
        }
    }
    
    //MARK: Create and validate PaymentRequestBinary, Owners and Sender without PkiData
    
    func testCreateAndValidatePaymentRequestBinaryOwnersAndSenderWithoutPkiDataNone() throws {
        let paymentRequestParameters = PaymentRequestParameters()
        paymentRequestParameters.network = "main"
        paymentRequestParameters.beneficiariesAddresses = TestData.Outputs.outputs
        paymentRequestParameters.time = Date().timeIntervalSince1970
        paymentRequestParameters.expires = Date().timeIntervalSince1970
        paymentRequestParameters.memo = "memo"
        paymentRequestParameters.paymentUrl = "www.payment.url/test"
        paymentRequestParameters.merchantData = "merchantData"
        paymentRequestParameters.beneficiaryParameters = [TestData.Beneficiaries.primaryBeneficiaryParametersPkiNone,
                                                          TestData.Beneficiaries.noPrimaryBeneficiaryParametersPkiNone]
        
        paymentRequestParameters.senderParameters = TestData.Senders.senderPkiNone
        paymentRequestParameters.attestationsRequested = TestData.Attestations.requestedAttestations

        if let paymentRequestBinary = try self.transactId.createPaymentRequest(paymentRequestParameters: paymentRequestParameters) {
            let isPaymentRequestValid = try self.transactId.isPaymentRequestValid(paymentRequestBinary: paymentRequestBinary)
            XCTAssert(isPaymentRequestValid)
        } else {
            XCTFail("Failed to Create PaymentRequestBinary")
        }
    }
    
    //MARK: Create and validate PaymentRequestBinary, Owners and Sender without PkiData
    
    func testCreateAndValidatePaymentRequestBinaryOwnersAndSenderWithoutPkiDataX509SHA256() throws {
        let paymentRequestParameters = PaymentRequestParameters()
        paymentRequestParameters.network = "main"
        paymentRequestParameters.beneficiariesAddresses = TestData.Outputs.outputs
        paymentRequestParameters.time = Date().timeIntervalSince1970
        paymentRequestParameters.expires = Date().timeIntervalSince1970
        paymentRequestParameters.memo = "memo"
        paymentRequestParameters.paymentUrl = "www.payment.url/test"
        paymentRequestParameters.merchantData = "merchantData"
        paymentRequestParameters.beneficiaryParameters = [TestData.Beneficiaries.primaryBeneficiaryParametersPkiX509SHA256,
                                                          TestData.Beneficiaries.noPrimaryBeneficiaryParametersPkiX509SHA256]
        
        paymentRequestParameters.senderParameters = TestData.Senders.senderPkiNone
        paymentRequestParameters.attestationsRequested = TestData.Attestations.requestedAttestations

        if let paymentRequestBinary = try self.transactId.createPaymentRequest(paymentRequestParameters: paymentRequestParameters) {
            let isPaymentRequestValid = try self.transactId.isPaymentRequestValid(paymentRequestBinary: paymentRequestBinary)
            XCTAssert(isPaymentRequestValid)
        } else {
            XCTFail("Failed to Create PaymentRequestBinary")
        }
    }
    
    //MARK: Create and validate PaymentRequestBinary, Owners without PkiData and Sender with PkiData
    
    func testCreateAndValidatePaymentRequestBinaryOwnersWithoutPkiDataAndSenderWithPkiDataX509SHA256() throws {
        let paymentRequestParameters = PaymentRequestParameters()
        paymentRequestParameters.network = "main"
        paymentRequestParameters.beneficiariesAddresses = TestData.Outputs.outputs
        paymentRequestParameters.time = Date().timeIntervalSince1970
        paymentRequestParameters.expires = Date().timeIntervalSince1970
        paymentRequestParameters.memo = "memo"
        paymentRequestParameters.paymentUrl = "www.payment.url/test"
        paymentRequestParameters.merchantData = "merchantData"
        paymentRequestParameters.beneficiaryParameters = [TestData.Beneficiaries.primaryBeneficiaryParametersPkiNone,
                                                          TestData.Beneficiaries.noPrimaryBeneficiaryParametersPkiNone]
        
        paymentRequestParameters.senderParameters = TestData.Senders.senderPkiX509SHA256
        paymentRequestParameters.attestationsRequested = TestData.Attestations.requestedAttestations

        if let paymentRequestBinary = try self.transactId.createPaymentRequest(paymentRequestParameters: paymentRequestParameters) {
            let isPaymentRequestValid = try self.transactId.isPaymentRequestValid(paymentRequestBinary: paymentRequestBinary)
            XCTAssert(isPaymentRequestValid)
        } else {
            XCTFail("Failed to Create PaymentRequestBinary")
        }
    }
    
    //MARK: Create and validate PaymentRequestBinary, one Owner with PkiData, one Owner without data and Sender with PkiData
    
    func testCreateAndValidatePaymentRequestBinaryOneOwnerWithPkiDataOneOwnerWithoutDataAndSenderWithPkiData() throws {
        let paymentRequestParameters = PaymentRequestParameters()
        paymentRequestParameters.network = "main"
        paymentRequestParameters.beneficiariesAddresses = TestData.Outputs.outputs
        paymentRequestParameters.time = Date().timeIntervalSince1970
        paymentRequestParameters.expires = Date().timeIntervalSince1970
        paymentRequestParameters.memo = "memo"
        paymentRequestParameters.paymentUrl = "www.payment.url/test"
        paymentRequestParameters.merchantData = "merchantData"
        paymentRequestParameters.beneficiaryParameters = [TestData.Beneficiaries.primaryBeneficiaryParametersPkiX509SHA256,
                                                          TestData.Beneficiaries.noPrimaryBeneficiaryParametersPkiNone]
        
        paymentRequestParameters.senderParameters = TestData.Senders.senderPkiX509SHA256
        paymentRequestParameters.attestationsRequested = TestData.Attestations.requestedAttestations

        if let paymentRequestBinary = try self.transactId.createPaymentRequest(paymentRequestParameters: paymentRequestParameters) {
            let isPaymentRequestValid = try self.transactId.isPaymentRequestValid(paymentRequestBinary: paymentRequestBinary)
            XCTAssert(isPaymentRequestValid)
        } else {
            XCTFail("Failed to Create PaymentRequestBinary")
        }
    }
    
    //MARK: Create and validate PaymentRequestBinary, Owners with PkiData and Sender with PkiData but invalid certificate chain
    
    func testCreateAndValidatePaymentRequestBinaryOwnersWithPkiDataAndSenderWithPkiDataButInvalidCertificateChain() throws {
        let paymentRequestParameters = PaymentRequestParameters()
        paymentRequestParameters.network = "main"
        paymentRequestParameters.beneficiariesAddresses = TestData.Outputs.outputs
        paymentRequestParameters.time = Date().timeIntervalSince1970
        paymentRequestParameters.expires = Date().timeIntervalSince1970
        paymentRequestParameters.memo = "memo"
        paymentRequestParameters.paymentUrl = "www.payment.url/test"
        paymentRequestParameters.merchantData = "merchantData"
        paymentRequestParameters.beneficiaryParameters = [TestData.Beneficiaries.primaryBeneficiaryParametersPkiX509SHA256,
                                                          TestData.Beneficiaries.noPrimaryBeneficiaryParametersPkiX509SHA256]
        
        paymentRequestParameters.senderParameters = TestData.Senders.senderPkiX509SHA256InvalidCertificate
        paymentRequestParameters.attestationsRequested = TestData.Attestations.requestedAttestations

        if let paymentRequestBinary = try self.transactId.createPaymentRequest(paymentRequestParameters: paymentRequestParameters) {
            XCTAssertThrowsError(try self.transactId.isPaymentRequestValid(paymentRequestBinary: paymentRequestBinary)) { error in
                guard case Exception.InvalidCertificateChainException(ExceptionMessages.certificateValidationInvalidSenderCertificateCA) = error else {
                    return XCTFail()
                }
            }
        } else {
            XCTFail("Failed to Create PaymentRequestBinary")
        }
    }
    
    //MARK: Create and validate PaymentRequestBinary, Owners with PkiData but invalid certificate chain and Sender with PkiData
    
    func testCreateAndValidatePaymentRequestBinaryOwnersWithPkiDataButInvalidCertificateChainAndSenderWithPkiData() throws {
        let paymentRequestParameters = PaymentRequestParameters()
        paymentRequestParameters.network = "main"
        paymentRequestParameters.beneficiariesAddresses = TestData.Outputs.outputs
        paymentRequestParameters.time = Date().timeIntervalSince1970
        paymentRequestParameters.expires = Date().timeIntervalSince1970
        paymentRequestParameters.memo = "memo"
        paymentRequestParameters.paymentUrl = "www.payment.url/test"
        paymentRequestParameters.merchantData = "merchantData"
        paymentRequestParameters.beneficiaryParameters = [TestData.Beneficiaries.primaryBeneficiaryParametersPkiX509SHA256InvalidCertificate,
                                                          TestData.Beneficiaries.noPrimaryBeneficiaryParametersPkiX509SHA256]
        
        paymentRequestParameters.senderParameters = TestData.Senders.senderPkiX509SHA256
        paymentRequestParameters.attestationsRequested = TestData.Attestations.requestedAttestations

        if let paymentRequestBinary = try self.transactId.createPaymentRequest(paymentRequestParameters: paymentRequestParameters) {
            XCTAssertThrowsError(try self.transactId.isPaymentRequestValid(paymentRequestBinary: paymentRequestBinary)) { error in
                guard case Exception.InvalidCertificateChainException(ExceptionMessages.certificateValidationInvalidOwnerCertificateCA) = error else {
                    return XCTFail()
                }
            }
        } else {
            XCTFail("Failed to Create PaymentRequestBinary")
        }
    }
    
    //MARK: Create and parse PaymentRequestBinary to PaymentRequest
    
    func testCreateAndParsePaymentRequestBinaryToPaymentRequest() throws {
        let paymentRequestParameters = PaymentRequestParameters()
        paymentRequestParameters.network = "main"
        paymentRequestParameters.beneficiariesAddresses = TestData.Outputs.outputs
        paymentRequestParameters.time = TimeInterval(Int(Date().timeIntervalSince1970))
        paymentRequestParameters.expires = TimeInterval(Int(Date().timeIntervalSince1970))
        paymentRequestParameters.memo = "memo"
        paymentRequestParameters.paymentUrl = "www.payment.url/test"
        paymentRequestParameters.merchantData = "merchantData"
        paymentRequestParameters.beneficiaryParameters = [TestData.Beneficiaries.primaryBeneficiaryParametersPkiX509SHA256,
                                                          TestData.Beneficiaries.noPrimaryBeneficiaryParametersPkiX509SHA256]
        
        paymentRequestParameters.senderParameters = TestData.Senders.senderPkiX509SHA256
        paymentRequestParameters.attestationsRequested = TestData.Attestations.requestedAttestations
        
        if let paymentRequestBinary = try self.transactId.createPaymentRequest(paymentRequestParameters: paymentRequestParameters) {
            if let paymentRequest = try self.transactId.parsePaymentRequest(paymentRequestBinary: paymentRequestBinary) {
                XCTAssert(paymentRequest.network == paymentRequestParameters.network)
                XCTAssert(paymentRequest.time == paymentRequestParameters.time)
                XCTAssert(paymentRequest.expires == paymentRequestParameters.expires)
                XCTAssert(paymentRequest.memo == paymentRequestParameters.memo)
                XCTAssert(paymentRequest.paymentUrl == paymentRequestParameters.paymentUrl)
                XCTAssert(paymentRequest.merchantData == paymentRequestParameters.merchantData)
                XCTAssert(paymentRequest.beneficiariesAddresses.count == paymentRequestParameters.beneficiariesAddresses?.count)
                XCTAssert(paymentRequest.beneficiaries.count == 2)
                
                for (beneficiaryIndex, beneficiary) in paymentRequest.beneficiaries.enumerated() {
                    XCTAssert(beneficiary.isPrimaryForTransaction == paymentRequestParameters.beneficiaryParameters[beneficiaryIndex].isPrimaryForTransaction)
                    if let pkiDataSets = beneficiary.pkiDataSets {
                        for (pkiDataIndex, pkiData) in pkiDataSets.enumerated() {
                            let ownerPkiData = TestData.Beneficiaries.primaryBeneficiaryParametersPkiX509SHA256.pkiDataParametersSets![pkiDataIndex]
                            XCTAssert(pkiData.pkiType == ownerPkiData.type)
                            XCTAssert(pkiData.attestation == ownerPkiData.attestation)
                            XCTAssert(pkiData.certificate == ownerPkiData.certificatePem)
                            if (beneficiary.isPrimaryForTransaction) {
                                XCTAssert(!pkiData.signature.isEmpty)
                            } else {
                                XCTAssert(pkiData.signature.isEmpty)
                            }
                        }
                    }
                }
                
                XCTAssert(paymentRequest.senderPkiType == paymentRequestParameters.senderParameters?.pkiDataParameters?.type)
                XCTAssert(paymentRequest.senderPkiData == paymentRequestParameters.senderParameters?.pkiDataParameters?.certificatePem)
                XCTAssert(paymentRequest.senderSignature != nil)
                XCTAssert(!paymentRequest.protocolMessageMetadata!.identifier!.isEmpty)
                XCTAssert(paymentRequest.protocolMessageMetadata!.version == 1)
                XCTAssert(paymentRequest.protocolMessageMetadata!.statusCode == StatusCode.ok)
                XCTAssert(paymentRequest.protocolMessageMetadata!.statusMessage == nil || paymentRequest.protocolMessageMetadata!.statusMessage!.isEmpty)
                XCTAssert(paymentRequest.protocolMessageMetadata!.messageType == MessageType.paymentRequest)
            } else {
                XCTFail("Failed to Parse PaymentRequestBinary")
            }
        } else {
            XCTFail("Failed to Create PaymentRequestBinary")
        }
    }
    
    //MARK: Create and parse PaymentRequestBinary to PaymentRequest with message information
    
    func testCreateAndParsePaymentRequestBinaryToPaymentRequestWithMessageInformation() throws {
        let paymentRequestParameters = PaymentRequestParameters()
        paymentRequestParameters.network = "main"
        paymentRequestParameters.beneficiariesAddresses = TestData.Outputs.outputs
        paymentRequestParameters.time = TimeInterval(Int(Date().timeIntervalSince1970))
        paymentRequestParameters.expires = TimeInterval(Int(Date().timeIntervalSince1970))
        paymentRequestParameters.memo = "memo"
        paymentRequestParameters.paymentUrl = "www.payment.url/test"
        paymentRequestParameters.merchantData = "merchantData"
        paymentRequestParameters.beneficiaryParameters = [TestData.Beneficiaries.primaryBeneficiaryParametersPkiX509SHA256,
                                                          TestData.Beneficiaries.noPrimaryBeneficiaryParametersPkiX509SHA256]
        
        paymentRequestParameters.senderParameters = TestData.Senders.senderPkiX509SHA256
        paymentRequestParameters.attestationsRequested = TestData.Attestations.requestedAttestations
        paymentRequestParameters.messageInformation = TestData.MessageInformationData.messageInformationCancel
        
        if let paymentRequestBinary = try self.transactId.createPaymentRequest(paymentRequestParameters: paymentRequestParameters) {
            if let paymentRequest = try self.transactId.parsePaymentRequest(paymentRequestBinary: paymentRequestBinary) {
                XCTAssert(paymentRequest.network == paymentRequestParameters.network)
                XCTAssert(paymentRequest.time == paymentRequestParameters.time)
                XCTAssert(paymentRequest.expires == paymentRequestParameters.expires)
                XCTAssert(paymentRequest.memo == paymentRequestParameters.memo)
                XCTAssert(paymentRequest.paymentUrl == paymentRequestParameters.paymentUrl)
                XCTAssert(paymentRequest.merchantData == paymentRequestParameters.merchantData)
                XCTAssert(paymentRequest.beneficiariesAddresses.count == paymentRequestParameters.beneficiariesAddresses?.count)
                XCTAssert(paymentRequest.beneficiaries.count == 2)
                
                for (beneficiaryIndex, beneficiary) in paymentRequest.beneficiaries.enumerated() {
                    XCTAssert(beneficiary.isPrimaryForTransaction == paymentRequestParameters.beneficiaryParameters[beneficiaryIndex].isPrimaryForTransaction)
                    if let pkiDataSets = beneficiary.pkiDataSets {
                        for (pkiDataIndex, pkiData) in pkiDataSets.enumerated() {
                            let ownerPkiData = TestData.Beneficiaries.primaryBeneficiaryParametersPkiX509SHA256.pkiDataParametersSets![pkiDataIndex]
                            XCTAssert(pkiData.pkiType == ownerPkiData.type)
                            XCTAssert(pkiData.attestation == ownerPkiData.attestation)
                            XCTAssert(pkiData.certificate == ownerPkiData.certificatePem)
                            if (beneficiary.isPrimaryForTransaction) {
                                XCTAssert(!pkiData.signature.isEmpty)
                            } else {
                                XCTAssert(pkiData.signature.isEmpty)
                            }
                        }
                    }
                }
                
                XCTAssert(paymentRequest.senderPkiType == paymentRequestParameters.senderParameters?.pkiDataParameters?.type)
                XCTAssert(paymentRequest.senderPkiData == paymentRequestParameters.senderParameters?.pkiDataParameters?.certificatePem)
                XCTAssert(paymentRequest.senderSignature != nil)
                XCTAssert(!paymentRequest.protocolMessageMetadata!.identifier!.isEmpty)
                XCTAssert(paymentRequest.protocolMessageMetadata!.version == 1)
                XCTAssert(paymentRequest.protocolMessageMetadata!.statusCode == StatusCode.cancel)
                XCTAssert(paymentRequest.protocolMessageMetadata!.statusMessage == TestData.MessageInformationData.messageInformationCancel.statusMessage)
                XCTAssert(paymentRequest.protocolMessageMetadata!.messageType == MessageType.paymentRequest)
            } else {
                XCTFail("Failed to Parse PaymentRequestBinary")
            }
        } else {
            XCTFail("Failed to Create PaymentRequestBinary")
        }
    }
    
    //MARK: Validate invalid PaymentRequestBinary
    
    func testValidateInvalidPaymentRequestBinary() throws {
        XCTAssertThrowsError(try self.transactId.isPaymentRequestValid(paymentRequestBinary: "fakePaymentRequest".data(using: .utf8)!)) { error in
            guard case Exception.InvalidObjectException("Invalid object for message, error: The operation couldn’t be completed. (SwiftProtobuf.BinaryDecodingError error 3.)") = error else {
                return XCTFail()
            }
        }
    }
    
    //MARK: Create and validate PaymentRequestBinary Encrypted, Owners and Sender with PkiData
    
    func testCreateAndValidatePaymentRequestBinaryEncryptedOwnersAndSenderWithPkiData() throws {
        let paymentRequestParameters = PaymentRequestParameters()
        paymentRequestParameters.network = "main"
        paymentRequestParameters.beneficiariesAddresses = TestData.Outputs.outputs
        paymentRequestParameters.time = TimeInterval(Int(Date().timeIntervalSince1970))
        paymentRequestParameters.expires = TimeInterval(Int(Date().timeIntervalSince1970))
        paymentRequestParameters.memo = "memo"
        paymentRequestParameters.paymentUrl = "www.payment.url/test"
        paymentRequestParameters.merchantData = "merchantData"
        paymentRequestParameters.beneficiaryParameters = [TestData.Beneficiaries.primaryBeneficiaryParametersPkiX509SHA256,
                                                          TestData.Beneficiaries.noPrimaryBeneficiaryParametersPkiX509SHA256]
        
        paymentRequestParameters.senderParameters = TestData.Senders.senderPkiX509SHA256WithEncryption
        paymentRequestParameters.attestationsRequested = TestData.Attestations.requestedAttestations
        paymentRequestParameters.messageInformation = TestData.MessageInformationData.messageInformationCancel
        paymentRequestParameters.recipientParameters = TestData.Recipients.recipientsParametersWithEncryption
        
        if let paymentRequestBinary = try self.transactId.createPaymentRequest(paymentRequestParameters: paymentRequestParameters) {
            XCTAssert(try self.transactId.isPaymentRequestValid(paymentRequestBinary: paymentRequestBinary, recipientParameters: TestData.Recipients.recipientsParametersWithEncryption))
        } else {
            XCTFail("Failed to Create PaymentRequestBinary")
        }
        
    }
    
    //MARK: Create and validate PaymentRequestBinary Encrypted, Owners and Sender with PkiData without RecipientParametersEncryptionParameters
    
    func testCreateAndValidatePaymentRequestBinaryEncryptedOwnersAndSenderWithPkiDataWithoutRecipientParametersEncryptionParameters() throws {
        let paymentRequestParameters = PaymentRequestParameters()
        paymentRequestParameters.network = "main"
        paymentRequestParameters.beneficiariesAddresses = TestData.Outputs.outputs
        paymentRequestParameters.time = TimeInterval(Int(Date().timeIntervalSince1970))
        paymentRequestParameters.expires = TimeInterval(Int(Date().timeIntervalSince1970))
        paymentRequestParameters.memo = "memo"
        paymentRequestParameters.paymentUrl = "www.payment.url/test"
        paymentRequestParameters.merchantData = "merchantData"
        paymentRequestParameters.beneficiaryParameters = [TestData.Beneficiaries.primaryBeneficiaryParametersPkiX509SHA256,
                                                          TestData.Beneficiaries.noPrimaryBeneficiaryParametersPkiX509SHA256]
        
        paymentRequestParameters.senderParameters = TestData.Senders.senderPkiX509SHA256WithEncryption
        paymentRequestParameters.attestationsRequested = TestData.Attestations.requestedAttestations
        paymentRequestParameters.messageInformation = TestData.MessageInformationData.messageInformationEncryption
        paymentRequestParameters.recipientParameters = TestData.Recipients.recipientsParametersWithEncryption
        
        if let paymentRequestBinary = try self.transactId.createPaymentRequest(paymentRequestParameters: paymentRequestParameters) {
            XCTAssertThrowsError(try self.transactId.isPaymentRequestValid(paymentRequestBinary: paymentRequestBinary)) { error in
                guard case Exception.EncryptionException(ExceptionMessages.decryptionMissingRecipientKeysError) = error else {
                    return XCTFail()
                }
            }
        } else {
            XCTFail("Failed to Create PaymentRequestBinary")
        }
    }
    
    //MARK: Create and validate PaymentRequestBinary encrypted, without sender's public and private key
    
    func testCreateAndValidatePaymentRequestBinaryEncryptedWithoutSendersPublicAndPrivateKey() throws {
        
        let paymentRequestParameters = PaymentRequestParameters()
        paymentRequestParameters.network = "main"
        paymentRequestParameters.beneficiariesAddresses = TestData.Outputs.outputs
        paymentRequestParameters.time = TimeInterval(Int(Date().timeIntervalSince1970))
        paymentRequestParameters.expires = TimeInterval(Int(Date().timeIntervalSince1970))
        paymentRequestParameters.memo = "memo"
        paymentRequestParameters.paymentUrl = "www.payment.url/test"
        paymentRequestParameters.merchantData = "merchantData"
        paymentRequestParameters.beneficiaryParameters = [TestData.Beneficiaries.primaryBeneficiaryParametersPkiX509SHA256,
                                                          TestData.Beneficiaries.noPrimaryBeneficiaryParametersPkiX509SHA256]
        
        paymentRequestParameters.senderParameters = TestData.Senders.senderPkiX509SHA256
        paymentRequestParameters.attestationsRequested = TestData.Attestations.requestedAttestations
        paymentRequestParameters.messageInformation = TestData.MessageInformationData.messageInformationEncryption
        paymentRequestParameters.recipientParameters = TestData.Recipients.recipientsParametersWithEncryption
        
        XCTAssertThrowsError(try self.transactId.createPaymentRequest(paymentRequestParameters: paymentRequestParameters)) { error in
            guard case Exception.EncryptionException(ExceptionMessages.encryptionMissingSenderKeysError) = error else {
                return XCTFail()
            }
        }
    }
    
    //MARK: Create and validate PaymentRequestBinary encrypted, without recipient's public key
    
    func testCreateAndValidatePaymentRequestBinaryEncryptedWithoutRecipientsPublicKey() throws {
        let paymentRequestParameters = PaymentRequestParameters()
        paymentRequestParameters.network = "main"
        paymentRequestParameters.beneficiariesAddresses = TestData.Outputs.outputs
        paymentRequestParameters.time = TimeInterval(Int(Date().timeIntervalSince1970))
        paymentRequestParameters.expires = TimeInterval(Int(Date().timeIntervalSince1970))
        paymentRequestParameters.memo = "memo"
        paymentRequestParameters.paymentUrl = "www.payment.url/test"
        paymentRequestParameters.merchantData = "merchantData"
        paymentRequestParameters.beneficiaryParameters = [TestData.Beneficiaries.primaryBeneficiaryParametersPkiX509SHA256,
                                                          TestData.Beneficiaries.noPrimaryBeneficiaryParametersPkiX509SHA256]
        
        paymentRequestParameters.senderParameters = TestData.Senders.senderPkiX509SHA256
        paymentRequestParameters.attestationsRequested = TestData.Attestations.requestedAttestations
        paymentRequestParameters.messageInformation = TestData.MessageInformationData.messageInformationEncryption
        
        XCTAssertThrowsError(try self.transactId.createPaymentRequest(paymentRequestParameters: paymentRequestParameters)) { error in
            guard case Exception.EncryptionException(ExceptionMessages.encryptionMissingRecipientKeysError) = error else {
                return XCTFail()
            }
        }
    }
    
    //MARK: Create and parse PaymentRequestBinary encrypted to PaymentRequest
    
    func testCreateAndParsePaymentRequestBinaryEncryptedToPaymentRequest() throws {
        let paymentRequestParameters = PaymentRequestParameters()
        paymentRequestParameters.network = "main"
        paymentRequestParameters.beneficiariesAddresses = TestData.Outputs.outputs
        paymentRequestParameters.time = TimeInterval(Int(Date().timeIntervalSince1970))
        paymentRequestParameters.expires = TimeInterval(Int(Date().timeIntervalSince1970))
        paymentRequestParameters.memo = "memo"
        paymentRequestParameters.paymentUrl = "www.payment.url/test"
        paymentRequestParameters.merchantData = "merchantData"
        paymentRequestParameters.beneficiaryParameters = [TestData.Beneficiaries.primaryBeneficiaryParametersPkiX509SHA256,
                                                          TestData.Beneficiaries.noPrimaryBeneficiaryParametersPkiX509SHA256]
        
        paymentRequestParameters.senderParameters = TestData.Senders.senderPkiX509SHA256WithEncryption
        paymentRequestParameters.attestationsRequested = TestData.Attestations.requestedAttestations
        paymentRequestParameters.messageInformation = TestData.MessageInformationData.messageInformationEncryption
        paymentRequestParameters.recipientParameters = TestData.Recipients.recipientsParametersWithEncryption
        
        if let paymentRequestBinary = try self.transactId.createPaymentRequest(paymentRequestParameters: paymentRequestParameters) {
            if let paymentRequest = try self.transactId.parsePaymentRequest(paymentRequestBinary: paymentRequestBinary, recipientParameters: TestData.Recipients.recipientsParametersWithEncryption) {
                XCTAssert(paymentRequest.network == paymentRequestParameters.network)
                XCTAssert(paymentRequest.time == paymentRequestParameters.time)
                XCTAssert(paymentRequest.expires == paymentRequestParameters.expires)
                XCTAssert(paymentRequest.memo == paymentRequestParameters.memo)
                XCTAssert(paymentRequest.paymentUrl == paymentRequestParameters.paymentUrl)
                XCTAssert(paymentRequest.merchantData == paymentRequestParameters.merchantData)
                XCTAssert(paymentRequest.beneficiariesAddresses.count == paymentRequestParameters.beneficiariesAddresses?.count)
                XCTAssert(paymentRequest.beneficiaries.count == 2)
                
                for (beneficiaryIndex, beneficiary) in paymentRequest.beneficiaries.enumerated() {
                    XCTAssert(beneficiary.isPrimaryForTransaction == paymentRequestParameters.beneficiaryParameters[beneficiaryIndex].isPrimaryForTransaction)
                    if let pkiDataSets = beneficiary.pkiDataSets {
                        for (pkiDataIndex, pkiData) in pkiDataSets.enumerated() {
                            let ownerPkiData = TestData.Beneficiaries.primaryBeneficiaryParametersPkiX509SHA256.pkiDataParametersSets![pkiDataIndex]
                            XCTAssert(pkiData.pkiType == ownerPkiData.type)
                            XCTAssert(pkiData.attestation == ownerPkiData.attestation)
                            XCTAssert(pkiData.certificate == ownerPkiData.certificatePem)
                            if (beneficiary.isPrimaryForTransaction) {
                                XCTAssert(!pkiData.signature.isEmpty)
                            } else {
                                XCTAssert(pkiData.signature.isEmpty)
                            }
                        }
                    }
                }
                
                XCTAssert(paymentRequest.senderPkiType == paymentRequestParameters.senderParameters?.pkiDataParameters?.type)
                XCTAssert(paymentRequest.senderPkiData == paymentRequestParameters.senderParameters?.pkiDataParameters?.certificatePem)
                XCTAssert(paymentRequest.senderSignature != nil)
                XCTAssert(!paymentRequest.protocolMessageMetadata!.identifier!.isEmpty)
                XCTAssert(paymentRequest.protocolMessageMetadata!.version == 1)
                XCTAssert(paymentRequest.protocolMessageMetadata!.statusCode == StatusCode.ok)
                XCTAssert(paymentRequest.protocolMessageMetadata!.statusMessage == nil || paymentRequest.protocolMessageMetadata!.statusMessage!.isEmpty)
                XCTAssert(paymentRequest.protocolMessageMetadata!.messageType == MessageType.paymentRequest)
                XCTAssert(paymentRequest.protocolMessageMetadata!.encrypted)
                XCTAssert(!paymentRequest.protocolMessageMetadata!.encryptedMessage!.isEmpty)
                XCTAssert(!paymentRequest.protocolMessageMetadata!.recipientPublicKeyPem!.isEmpty)
                XCTAssert(!paymentRequest.protocolMessageMetadata!.senderPublicKeyPem!.isEmpty)
                XCTAssert(!paymentRequest.protocolMessageMetadata!.signature!.isEmpty)
                XCTAssert(paymentRequest.protocolMessageMetadata!.nonce! > 0)
            } else {
                XCTFail("Failed to Parse PaymentRequestBinary")
            }
        } else {
            XCTFail("Failed to Create PaymentRequestBinary")
        }
    }
    
}
