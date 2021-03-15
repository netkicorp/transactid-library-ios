//
//  transactId_library_ios_tests.swift
//  transactId_library_ios-tests
//
//  Created by Developer on 03.02.2021.
//

import XCTest
import transactId_library_ios

class transactId_library_ios_tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGenerateKeys() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
//        let generationResult = CSRUtilities().generateCertRequestOpenSSL(csrInfo: [])
        
//        if let result = generationResult {
//            
//            let csr = result.csrBase64
//            print("\n CERTIFICATE REQUEST:\n\n \(csr)");
//            XCTAssertNotEqual(csr, "")
//            XCTAssertNotNil(csr)
//            let privateKey = result.privateKeyBase64
//            print("\n PRIVATE KEY:\n\n \(privateKey)");
//            XCTAssertNotEqual(privateKey, "")
//            XCTAssertNotNil(privateKey)
//            let publicKey = result.publicKeyBase64
//            print("\n PUBLIC KEY :\n\n \(publicKey)");
//            XCTAssertNotEqual(publicKey, "")
//            XCTAssertNotNil(publicKey)
//        }
//        XCTAssertNotNil(generationResult)

    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
