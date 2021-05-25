//
//  TransactIdPaymentTests.swift
//  transactId_library_ios-tests
//
//  Created by Developer on 20.04.2021.
//

import Foundation
import XCTest
import transactId_library_ios

class TransactIdPaymentTests: XCTestCase {
    
    private let transactId = TransactId(trustStore: nil)
    
    //MARK: Create and validate PaymentBinary
    
    func testCreateAndValidatePaymentBinary() throws {
        let paymentParameters = PaymentParameters()
        paymentParameters.merchantData = "merchant data"
        paymentParameters.transactions = ["transaction1".toByteString(),
                                          "transaction2".toByteString()]
        
        paymentParameters.outputs = TestData.Outputs.outputs
        paymentParameters.memo = "memo"
        paymentParameters.originatorParameters = [TestData.Originators.primaryOriginatorPkiX509SHA256,
                                                  TestData.Originators.noPrimaryOriginatorPkiX509SHA256]
        
        paymentParameters.beneficiaryParameters = [TestData.Beneficiaries.primaryBeneficiaryParametersPkiX509SHA256]
        
        if let paymentBinary = try self.transactId.createPayment(paymentParameters: paymentParameters) {
            let isPaymentValid = try self.transactId.isPaymentValid(paymentBinary: paymentBinary)
            XCTAssert(isPaymentValid)
        } else {
            XCTFail("Failed to Create InvoiceRequestBinary")
        }
    }
    
    //MARK: Create and parse PaymentBinary to Payment
    
    func testCreateAndParsePaymentBinaryToPayment() throws {
        let paymentParameters = PaymentParameters()
        paymentParameters.merchantData = "merchant data"
        paymentParameters.transactions = ["transaction1".toByteString(),
                                          "transaction2".toByteString()]
        
        paymentParameters.outputs = TestData.Outputs.outputs
        paymentParameters.memo = "memo"
        paymentParameters.originatorParameters = [TestData.Originators.primaryOriginatorPkiX509SHA256,
                                                  TestData.Originators.noPrimaryOriginatorPkiX509SHA256]
        
        paymentParameters.beneficiaryParameters = [TestData.Beneficiaries.primaryBeneficiaryParametersPkiX509SHA256]
        
        if let paymentBinary = try self.transactId.createPayment(paymentParameters: paymentParameters) {
            if let payment = try self.transactId.parsePayment(paymentBinary: paymentBinary) {
                XCTAssert(payment.merchantData == paymentParameters.merchantData)
                XCTAssert(payment.transactions.count == paymentParameters.transactions.count)
                XCTAssert(payment.memo == paymentParameters.memo)
                XCTAssert(payment.originators.count == paymentParameters.originatorParameters.count)
                XCTAssert(payment.beneficiaries.count == paymentParameters.beneficiaryParameters.count)
                XCTAssert(!payment.protocolMessageMetadata!.identifier!.isEmpty)
                XCTAssert(payment.protocolMessageMetadata!.version == 1)
                XCTAssert(payment.protocolMessageMetadata!.statusCode == StatusCode.ok)
                XCTAssert(payment.protocolMessageMetadata!.statusMessage!.isEmpty)
                XCTAssert(payment.protocolMessageMetadata!.messageType == MessageType.payment)
            } else {
                XCTFail("Failed to Parse PaymentBinary to Payment")
            }
        } else {
            XCTFail("Failed to Create InvoiceRequestBinary")
        }
    }
    
    //MARK: Create and parse PaymentBinary to Payment with message information
    
    func testCreateAndParsePaymentBinaryToPaymentWithMessageInformation() throws {
        let paymentParameters = PaymentParameters()
        paymentParameters.merchantData = "merchant data"
        paymentParameters.transactions = ["transaction1".toByteString(),
                                          "transaction2".toByteString()]
        
        paymentParameters.outputs = TestData.Outputs.outputs
        paymentParameters.memo = "memo"
        paymentParameters.originatorParameters = [TestData.Originators.primaryOriginatorPkiX509SHA256,
                                                  TestData.Originators.noPrimaryOriginatorPkiX509SHA256]
        
        paymentParameters.beneficiaryParameters = []
        paymentParameters.messageInformation = TestData.MessageInformationData.messageInformationCancel
        
        if let paymentBinary = try self.transactId.createPayment(paymentParameters: paymentParameters) {
            if let payment = try self.transactId.parsePayment(paymentBinary: paymentBinary) {
                XCTAssert(payment.merchantData == paymentParameters.merchantData)
                XCTAssert(payment.transactions.count == paymentParameters.transactions.count)
                XCTAssert(payment.memo == paymentParameters.memo)
                XCTAssert(payment.originators.count == paymentParameters.originatorParameters.count)
                XCTAssert(payment.beneficiaries.count == paymentParameters.beneficiaryParameters.count)
                XCTAssert(!payment.protocolMessageMetadata!.identifier!.isEmpty)
                XCTAssert(payment.protocolMessageMetadata!.version == 1)
                XCTAssert(payment.protocolMessageMetadata!.statusCode == StatusCode.cancel)
                XCTAssert(payment.protocolMessageMetadata!.statusMessage == TestData.MessageInformationData.messageInformationCancel.statusMessage)
                XCTAssert(payment.protocolMessageMetadata!.messageType == MessageType.payment)
            } else {
                XCTFail("Failed to Parse PaymentBinary to Payment")
            }
        } else {
            XCTFail("Failed to Create InvoiceRequestBinary")
        }
    }
    
    //MARK: Create and validate PaymentBinary Encrypted, Owners and Sender with PkiData
    
    func testCreateAndValidatePaymentBinaryEncryptedOwnersAndSenderWithPkiData() throws {
        
        let paymentParameters = PaymentParameters()
        paymentParameters.merchantData = "merchant data"
        paymentParameters.transactions = ["transaction1".toByteString(),
                                          "transaction2".toByteString()]
        
        paymentParameters.outputs = TestData.Outputs.outputs
        paymentParameters.memo = "memo"
        paymentParameters.originatorParameters = [TestData.Originators.primaryOriginatorPkiX509SHA256,
                                                  TestData.Originators.noPrimaryOriginatorPkiX509SHA256]
        
        paymentParameters.beneficiaryParameters = [TestData.Beneficiaries.primaryBeneficiaryParametersPkiNone]
        paymentParameters.messageInformation = TestData.MessageInformationData.messageInformationEncryption
        paymentParameters.senderParameters = TestData.Senders.senderPkiX509SHA256WithEncryption
        paymentParameters.recipientParameters = TestData.Recipients.recipientsParametersWithEncryption
        
        if let paymentBinary = try self.transactId.createPayment(paymentParameters: paymentParameters) {
            let isPaymentValid = try self.transactId.isPaymentValid(paymentBinary: paymentBinary, recipientParameters: TestData.Recipients.recipientsParametersWithEncryption)
            XCTAssert(isPaymentValid)
        } else {
            XCTFail("Failed to Create InvoiceRequestBinary")
        }
    
    }
    
    //MARK: Create and validate PaymentBinary Encrypted, Owners and Sender with PkiData without RecipientParametersEncryptionParameters
    
    func testCreateAndValidatePaymentBinaryEncryptedOwnersAndSenderWithPkiDataWithoutRecipientParametersEncryptionParameters() throws {
        let paymentParameters = PaymentParameters()
        paymentParameters.merchantData = "merchant data"
        paymentParameters.transactions = ["transaction1".toByteString(),
                                          "transaction2".toByteString()]
        
        paymentParameters.outputs = TestData.Outputs.outputs
        paymentParameters.memo = "memo"
        paymentParameters.originatorParameters = [TestData.Originators.primaryOriginatorPkiX509SHA256,
                                                  TestData.Originators.noPrimaryOriginatorPkiX509SHA256]
        
        paymentParameters.beneficiaryParameters = [TestData.Beneficiaries.primaryBeneficiaryParametersPkiNone]
        paymentParameters.messageInformation = TestData.MessageInformationData.messageInformationEncryption
        paymentParameters.senderParameters = TestData.Senders.senderPkiX509SHA256WithEncryption
        paymentParameters.recipientParameters = TestData.Recipients.recipientsParametersWithEncryption
        
        if let paymentBinary = try self.transactId.createPayment(paymentParameters: paymentParameters) {
            XCTAssertThrowsError(try self.transactId.isPaymentValid(paymentBinary: paymentBinary)) { error in
                guard case Exception.EncryptionException(ExceptionMessages.decryptionMissingRecipientKeysError) = error else {
                    return XCTFail()
                }
            }
        } else {
            XCTFail("Failed to Create InvoiceRequestBinary")
        }
    }
    
    //MARK: Create and validate PaymentBinary encrypted, without sender's public and private key
    
    func testCreateAndValidatePaymentBinaryEncryptedWithoutSenderPublicAndPrivateKey() throws {
        let paymentParameters = PaymentParameters()
        paymentParameters.merchantData = "merchant data"
        paymentParameters.transactions = ["transaction1".toByteString(),
                                          "transaction2".toByteString()]
        
        paymentParameters.outputs = TestData.Outputs.outputs
        paymentParameters.memo = "memo"
        paymentParameters.originatorParameters = [TestData.Originators.primaryOriginatorPkiX509SHA256,
                                                  TestData.Originators.noPrimaryOriginatorPkiX509SHA256]
        
        paymentParameters.beneficiaryParameters = []
        paymentParameters.messageInformation = TestData.MessageInformationData.messageInformationEncryption
        paymentParameters.senderParameters = TestData.Senders.senderPkiX509SHA256
        paymentParameters.recipientParameters = TestData.Recipients.recipientsParametersWithEncryption
        
        XCTAssertThrowsError(try self.transactId.createPayment(paymentParameters: paymentParameters)) { error in
            guard case Exception.EncryptionException(ExceptionMessages.encryptionMissingSenderKeysError) = error else {
                return XCTFail()
            }
        }
    }
    
    //MARK: Create and validate PaymentBinary encrypted, without recipient's public key
    
    func testCreateAndValidatePaymentBinaryEncryptedWithoutRecipientPublicKey() throws {
        let paymentParameters = PaymentParameters()
        paymentParameters.merchantData = "merchant data"
        paymentParameters.transactions = ["transaction1".toByteString(),
                                          "transaction2".toByteString()]
        
        paymentParameters.outputs = TestData.Outputs.outputs
        paymentParameters.memo = "memo"
        paymentParameters.originatorParameters = [TestData.Originators.primaryOriginatorPkiX509SHA256,
                                                  TestData.Originators.noPrimaryOriginatorPkiX509SHA256]
        
        paymentParameters.messageInformation = TestData.MessageInformationData.messageInformationEncryption
        paymentParameters.senderParameters = TestData.Senders.senderPkiX509SHA256WithEncryption
        
        XCTAssertThrowsError(try self.transactId.createPayment(paymentParameters: paymentParameters)) { error in
            guard case Exception.EncryptionException(ExceptionMessages.encryptionMissingRecipientKeysError) = error else {
                return XCTFail()
            }
        }
    }
    
    //MARK: Create and parse PaymentBinary encrypted to Payment
    
    func testCreateAndParsePaymentBinaryEncryptedToPayment() throws {
        let paymentParameters = PaymentParameters()
        paymentParameters.merchantData = "merchant data"
        paymentParameters.transactions = ["transaction1".toByteString(),
                                          "transaction2".toByteString()]
        
        paymentParameters.outputs = TestData.Outputs.outputs
        paymentParameters.memo = "memo"
        paymentParameters.originatorParameters = [TestData.Originators.primaryOriginatorPkiX509SHA256,
                                                  TestData.Originators.noPrimaryOriginatorPkiX509SHA256]
        
        paymentParameters.beneficiaryParameters = [TestData.Beneficiaries.primaryBeneficiaryParametersPkiNone]
        paymentParameters.messageInformation = TestData.MessageInformationData.messageInformationEncryption
        paymentParameters.senderParameters = TestData.Senders.senderPkiX509SHA256WithEncryption
        paymentParameters.recipientParameters = TestData.Recipients.recipientsParametersWithEncryption
        
        if let paymentBinary = try self.transactId.createPayment(paymentParameters: paymentParameters) {
            if let payment = try self.transactId.parsePayment(paymentBinary: paymentBinary, recipientParameters: TestData.Recipients.recipientsParametersWithEncryption) {
                XCTAssert(payment.merchantData == paymentParameters.merchantData)
                XCTAssert(payment.transactions.count == paymentParameters.transactions.count)
                XCTAssert(payment.memo == paymentParameters.memo)
                XCTAssert(payment.originators.count == paymentParameters.originatorParameters.count)
                XCTAssert(payment.beneficiaries.count == paymentParameters.beneficiaryParameters.count)
                XCTAssert(!payment.protocolMessageMetadata!.identifier!.isEmpty)
                XCTAssert(payment.protocolMessageMetadata!.version == 1)
                XCTAssert(payment.protocolMessageMetadata!.statusCode == StatusCode.ok)
                XCTAssert(payment.protocolMessageMetadata!.messageType == MessageType.payment)
                XCTAssert(payment.protocolMessageMetadata!.encrypted)
                XCTAssert(!payment.protocolMessageMetadata!.encryptedMessage!.isEmpty)
                XCTAssert(!payment.protocolMessageMetadata!.recipientPublicKeyPem!.isEmpty)
                XCTAssert(!payment.protocolMessageMetadata!.senderPublicKeyPem!.isEmpty)
                XCTAssert(!payment.protocolMessageMetadata!.signature!.isEmpty)
                XCTAssert(payment.protocolMessageMetadata!.nonce! > 0)
            } else {
                XCTFail("Failed to Parse PaymentBinary to Payment")
            }
        } else {
            XCTFail("Failed to Create InvoiceRequestBinary")
        }
    }
    
    //MARK: Validate invalid PaymentBinary
    
    func testValidateInvalidPaymentBinary() throws {
        XCTAssertThrowsError(try self.transactId.isPaymentValid(paymentBinary: "fakePaymentBinary".data(using: .utf8)!)) { error in
            guard case Exception.InvalidObjectException("Invalid object for message, error: The operation couldn’t be completed. (SwiftProtobuf.BinaryDecodingError error 3.)") = error else {
                return XCTFail()
            }
        }
    }

}
