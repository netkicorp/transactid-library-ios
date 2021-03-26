//
//  String+Extension.swift
//  transactId-library-ios
//
//  Created by Developer on 19.03.2021.
//

import Foundation

extension String {
    
    func toByteString() -> Data {
        let byteArray = [UInt8](self.utf8)
        return Data(byteArray)
    }
    
    func base64() -> String? {
        return self.data(using: .utf8)?.base64EncodedString()
    }
}
