//
//  TransactIdPaymentACKTests.swift
//  transactId_library_ios-tests
//
//  Created by Developer on 20.04.2021.
//
import Foundation
import XCTest
import transactId_library_ios

class TransactIdPaymentACKTests: XCTestCase {
    
    private let transactId = TransactId(trustStore: nil)
    
    var payment: Payment {
        let payment = Payment()
        payment.merchantData = "merchant data"
        payment.transactions = ["transaction 1".toByteString().toByteArray(),
                                "transaction2".toByteString().toByteArray()]
        
        payment.outputs = TestData.Outputs.outputs
        payment.memo = "memo"
        
        let pkiData = PkiData()
        pkiData.attestation = Attestation.addressCountry
        pkiData.certificate = TestData.Certificates.clientCertificateChainOne
        pkiData.pkiType = PkiType.x509sha256
        
        let beneficiary = Beneficiary()
        beneficiary.isPrimaryForTransaction = true
        beneficiary.pkiDataSets = [pkiData]
        
        let originator = Originator()
        originator.isPrimaryForTransaction = true
        originator.pkiDataSets = [pkiData]
        payment.beneficiaries = [beneficiary]
        
        let protocolMessageMetadata = ProtocolMessageMetadata()
        protocolMessageMetadata.version = 1
        protocolMessageMetadata.statusCode = StatusCode.ok
        protocolMessageMetadata.statusMessage = ""
        protocolMessageMetadata.messageType = MessageType.payment
        protocolMessageMetadata.identifier = "random identifier"
        
        payment.protocolMessageMetadata = protocolMessageMetadata
    
        return payment
    }
    
    //MARK: Create and validate PaymentAckBinary
    
    func testCreateAndValidatePaymentAckBinary() throws {
        let paymentAckParameters = PaymentAckParameters()
        paymentAckParameters.memo = "memo"
        paymentAckParameters.payment = self.payment
        
        if let paymentAckBinary = try self.transactId.createPaymentACK(paymentAckParameters: paymentAckParameters) {
            let isPaymentAckValid = try self.transactId.isPaymentACKValid(paymentAckBinary: paymentAckBinary)
            XCTAssert(isPaymentAckValid)
            
        } else {
            XCTFail("Failed to Create PaymentAckBinary")
        }
    }
    
    //MARK: Create and parse PaymentAckBinary to PaymentAck
    
    func testCreateAndParsePaymentAckBinaryToPaymentAck() throws {
        let paymentAckParameters = PaymentAckParameters()
        paymentAckParameters.memo = "memo_payment_ack"
        paymentAckParameters.payment = self.payment
        
        if let paymentAckBinary = try self.transactId.createPaymentACK(paymentAckParameters: paymentAckParameters) {
            if let paymentAck = try self.transactId.parsePaymentACK(paymentAckBinary: paymentAckBinary) {
                XCTAssert(paymentAck.payment!.merchantData == self.payment.merchantData)
                XCTAssert(paymentAck.payment!.transactions.count == self.payment.transactions.count)
                XCTAssert(paymentAck.payment!.originators.count == self.payment.originators.count)
                XCTAssert(paymentAck.payment!.memo == self.payment.memo)
                XCTAssert(paymentAck.payment!.protocolMessageMetadata == nil)
                XCTAssert(paymentAck.memo == paymentAckParameters.memo)
                XCTAssert(!paymentAck.protocolMessageMetadata!.identifier!.isEmpty)
                XCTAssert(paymentAck.protocolMessageMetadata!.version == 1)
                XCTAssert(paymentAck.protocolMessageMetadata!.statusCode == StatusCode.ok)
                XCTAssert(paymentAck.protocolMessageMetadata!.statusMessage!.isEmpty)
                XCTAssert(paymentAck.protocolMessageMetadata!.messageType == MessageType.paymentACK)
            } else {
                XCTFail("Failed to Parse PaymentAckBinary to PaymentAck")
            }
        } else {
            XCTFail("Failed to Create PaymentAckBinary")
        }
        
    }
    
    //MARK: Create and validate PaymentAckBinary with message information
    
    func testCreateAndValidatePaymentAckBinaryWithMessageInformation() throws {
        let paymentAckParameters = PaymentAckParameters()
        paymentAckParameters.memo = "memo"
        paymentAckParameters.payment = self.payment
        paymentAckParameters.messageInformation = TestData.MessageInformationData.messageInformationCancel
        
        if let paymentAckBinary = try self.transactId.createPaymentACK(paymentAckParameters: paymentAckParameters) {
            let isPaymentAckValid = try self.transactId.isPaymentACKValid(paymentAckBinary: paymentAckBinary)
            XCTAssert(isPaymentAckValid)
            
        } else {
            XCTFail("Failed to Create PaymentAckBinary")
        }
    }
    
    //MARK: Create and parse PaymentAckBinary to PaymentAck with message information
    
    func testCreateAndParsePaymentAckBinaryToPaymentAckWithMessageInformation() throws {
        let paymentAckParameters = PaymentAckParameters()
        paymentAckParameters.memo = "memo_payment_ack"
        paymentAckParameters.payment = self.payment
        paymentAckParameters.messageInformation = TestData.MessageInformationData.messageInformationCancel
        
        if let paymentAckBinary = try self.transactId.createPaymentACK(paymentAckParameters: paymentAckParameters) {
            if let paymentAck = try self.transactId.parsePaymentACK(paymentAckBinary: paymentAckBinary) {
                XCTAssert(paymentAck.payment!.merchantData == self.payment.merchantData)
                XCTAssert(paymentAck.payment!.transactions.count == self.payment.transactions.count)
                XCTAssert(paymentAck.payment!.originators.count == self.payment.originators.count)
                XCTAssert(paymentAck.payment!.memo == self.payment.memo)
                XCTAssert(paymentAck.payment!.protocolMessageMetadata == nil)
                XCTAssert(paymentAck.memo == paymentAckParameters.memo)
                XCTAssert(!paymentAck.protocolMessageMetadata!.identifier!.isEmpty)
                XCTAssert(paymentAck.protocolMessageMetadata!.version == 1)
                XCTAssert(paymentAck.protocolMessageMetadata!.statusCode == StatusCode.cancel)
                XCTAssert(paymentAck.protocolMessageMetadata!.statusMessage == TestData.MessageInformationData.messageInformationCancel.statusMessage)
                XCTAssert(paymentAck.protocolMessageMetadata!.messageType == MessageType.paymentACK)
            } else {
                XCTFail("Failed to Parse PaymentAckBinary to PaymentAck")
            }
        } else {
            XCTFail("Failed to Create PaymentAckBinary")
        }
    }
    
    //MARK: Validate invalid PaymentAckBinary
    
    func testValidateInvalidPaymentAckBinary() throws {
        XCTAssertThrowsError(try self.transactId.isPaymentACKValid(paymentAckBinary: "fakePaymentAck".toByteString().toByteArray())) { error in
            guard case Exception.InvalidObjectException("Invalid object for message, error: The operation couldn’t be completed. (SwiftProtobuf.BinaryDecodingError error 3.)") = error else {
                return XCTFail()
            }
        }
    }
    
    //MARK: Create and validate PaymentAckBinary Encrypted, Owners and Sender with PkiData
    
    func testCreateAndValidatePaymentAckBinaryEncryptedOwnersAndSenderWithPkiData() throws {
        let paymentAckParameters = PaymentAckParameters()
        paymentAckParameters.memo = "memo"
        paymentAckParameters.payment = self.payment
        paymentAckParameters.messageInformation = TestData.MessageInformationData.messageInformationEncryption
        paymentAckParameters.senderParameters = TestData.Senders.senderPkiX509SHA256WithEncryption
        paymentAckParameters.recipientParameters = TestData.Recipients.recipientsParametersWithEncryption
        
        if let paymentAckBinary = try self.transactId.createPaymentACK(paymentAckParameters: paymentAckParameters) {
            let isPaymentAckValid = try self.transactId.isPaymentACKValid(paymentAckBinary: paymentAckBinary, recipientParameters: TestData.Recipients.recipientsParametersWithEncryption)
            XCTAssert(isPaymentAckValid)
        } else {
            XCTFail("Failed to Create PaymentAckBinary")
        }
    }
    
    //MARK: Create and validate PaymentAckBinary Encrypted, Owners and Sender with PkiData without RecipientParametersEncryptionParameters
    
    func testCreateAndValidatePaymentAckBinaryEncryptedOwnersAndSenderWithPkiDataWithoutRecipientParametersEncryptionParameters() throws {
        let paymentAckParameters = PaymentAckParameters()
        paymentAckParameters.memo = "memo"
        paymentAckParameters.payment = self.payment
        paymentAckParameters.messageInformation = TestData.MessageInformationData.messageInformationEncryption
        paymentAckParameters.senderParameters = TestData.Senders.senderPkiX509SHA256WithEncryption
        paymentAckParameters.recipientParameters = TestData.Recipients.recipientsParametersWithEncryption
        
        if let paymentAckBinary = try self.transactId.createPaymentACK(paymentAckParameters: paymentAckParameters) {
            XCTAssertThrowsError(try self.transactId.isPaymentACKValid(paymentAckBinary: paymentAckBinary)) { error in
                guard case Exception.EncryptionException(ExceptionMessages.decryptionMissingRecipientKeysError) = error else {
                    return XCTFail()
                }
            }
        } else {
            XCTFail("Failed to Create PaymentAckBinary")
        }
    }
    
    //MARK: Create and validate PaymentAckBinary encrypted, without sender's public and private key
    
    func testCreateAndValidatePaymentAckBinaryEncryptedWithoutSenderPublicAndPrivateKey() throws {
        let paymentAckParameters = PaymentAckParameters()
        paymentAckParameters.memo = "memo"
        paymentAckParameters.payment = self.payment
        paymentAckParameters.messageInformation = TestData.MessageInformationData.messageInformationEncryption
        paymentAckParameters.senderParameters = TestData.Senders.senderPkiX509SHA256
        paymentAckParameters.recipientParameters = TestData.Recipients.recipientsParametersWithEncryption
        
        XCTAssertThrowsError(try self.transactId.createPaymentACK(paymentAckParameters: paymentAckParameters)) { error in
            guard case Exception.EncryptionException(ExceptionMessages.encryptionMissingSenderKeysError) = error else {
                return XCTFail()
            }
        }
    }
    
    //MARK: Create and validate PaymentAckBinary encrypted, without recipient's public key
    
    func testCreateAndValidatePaymentAckBinaryEncryptedWithoutRecipientPublicKey() throws {
        let paymentAckParameters = PaymentAckParameters()
        paymentAckParameters.memo = "memo"
        paymentAckParameters.payment = self.payment
        paymentAckParameters.messageInformation = TestData.MessageInformationData.messageInformationEncryption
        paymentAckParameters.senderParameters = TestData.Senders.senderPkiX509SHA256
        paymentAckParameters.recipientParameters = TestData.Recipients.recipientsParameters
        
        XCTAssertThrowsError(try self.transactId.createPaymentACK(paymentAckParameters: paymentAckParameters)) { error in
            guard case Exception.EncryptionException(ExceptionMessages.encryptionMissingRecipientKeysError) = error else {
                return XCTFail()
            }
        }
    }
    
    //MARK: Create and parse PaymentAckBinary encrypted to PaymentAck
    
    func testCreateAndParsePaymentAckBinaryEncryptedToPaymentAck() throws {
        let paymentAckParameters = PaymentAckParameters()
        paymentAckParameters.memo = "memo_payment_ack"
        paymentAckParameters.payment = self.payment
        paymentAckParameters.messageInformation = TestData.MessageInformationData.messageInformationEncryption
        paymentAckParameters.senderParameters = TestData.Senders.senderPkiX509SHA256WithEncryption
        paymentAckParameters.recipientParameters = TestData.Recipients.recipientsParametersWithEncryption
        
        if let paymentAckBinary = try self.transactId.createPaymentACK(paymentAckParameters: paymentAckParameters) {
            if let paymentAck = try self.transactId.parsePaymentACK(paymentAckBinary: paymentAckBinary, recipientParameters: TestData.Recipients.recipientsParametersWithEncryption) {
                XCTAssert(paymentAck.payment!.merchantData == self.payment.merchantData)
                XCTAssert(paymentAck.payment!.transactions.count == self.payment.transactions.count)
                XCTAssert(paymentAck.payment!.originators.count == self.payment.originators.count)
                XCTAssert(paymentAck.payment!.memo == self.payment.memo)
                XCTAssert(paymentAck.payment!.protocolMessageMetadata == nil)
                XCTAssert(paymentAck.memo == paymentAckParameters.memo)
                XCTAssert(!paymentAck.protocolMessageMetadata!.identifier!.isEmpty)
                XCTAssert(paymentAck.protocolMessageMetadata!.version == 1)
                XCTAssert(paymentAck.protocolMessageMetadata!.statusCode == StatusCode.ok)
                XCTAssert(paymentAck.protocolMessageMetadata!.messageType == MessageType.paymentACK)
                XCTAssert(paymentAck.protocolMessageMetadata!.encrypted)
                XCTAssert(!paymentAck.protocolMessageMetadata!.encryptedMessage!.isEmpty)
                XCTAssert(!paymentAck.protocolMessageMetadata!.recipientPublicKeyPem!.isEmpty)
                XCTAssert(!paymentAck.protocolMessageMetadata!.senderPublicKeyPem!.isEmpty)
                XCTAssert(!paymentAck.protocolMessageMetadata!.signature!.isEmpty)
                XCTAssert(paymentAck.protocolMessageMetadata!.nonce! > 0)
            } else {
                XCTFail("Failed to Parse PaymentAckBinary to PaymentAck")
            }
        } else {
            XCTFail("Failed to Create PaymentAckBinary")
        }
    }
    
}
