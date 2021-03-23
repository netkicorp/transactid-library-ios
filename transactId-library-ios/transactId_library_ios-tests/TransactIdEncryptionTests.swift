//
//  TransactIdEncryptionTests.swift
//  transactId_library_ios-tests
//
//  Created by Developer on 22.03.2021.
//

import Foundation
import XCTest
import transactId_library_ios

class TransactIdEncryptionTests: XCTestCase {
    
    private let transactId = TransactId(trustStore: nil)

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testDecryptEncryptedMessage() throws {
        
        let encryptedMessage = "04c32a6cdbe070106365ca8ea549a21ad82d603cbbbd7fd7ca64f8f4a1daa6a9624c227abb4648e53a9aa3c4be577af839bd026d2788f4bbb86b37e732e4e7ea6b4175B37ECFC92B84384E3C23E50D633C8BA40BAA92BC989843311C353757EF09EC8F0909"
        
        let receiverPrivateKeyPem =
            "-----BEGIN PRIVATE KEY-----\n" +
            "MD4CAQAwEAYHKoZIzj0CAQYFK4EEAAoEJzAlAgEBBCCCYuZeldJmVla0MVfFLx7M\n" +
            "BE51sH36Pg32Sn3ezMOUbA==\n" +
            "-----END PRIVATE KEY-----"

        let senderPublicKeyPem =
            "-----BEGIN PUBLIC KEY-----\n" +
            "MFYwEAYHKoZIzj0CAQYFK4EEAAoDQgAEwyps2+BwEGNlyo6lSaIa2C1gPLu9f9fK\n" +
            "ZPj0odqmqWJMInq7RkjlOpqjxL5Xevg5vQJtJ4j0u7hrN+cy5Ofqaw==\n" +
            "-----END PUBLIC KEY-----"
        
        let message = OpenSSLTools().decrypt(encryptedMessage, receiverPrivateKey: receiverPrivateKeyPem, senderPublicKey: senderPublicKeyPem)
                
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
