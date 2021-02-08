//
//  Csr.swift
//  transactId-library-ios
//
//  Created by Developer on 02.02.2021.
//

import Foundation
import SwiftyJSON

public class Csr {
    var attestationField: String?
    var csr: String?
    var value: String?
    
    init(fromJSON: JSON) {
        self.attestationField = fromJSON["attestation_field"].string
        self.csr = fromJSON["csr"].string
        self.value = fromJSON["value"].string
    }
}
