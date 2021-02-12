//
//  Attestation.swift
//  transactId-library-ios
//
//  Created by Developer on 02.02.2021.
//

import Foundation

class Attestation {
    var attestationField: String?
    var csr: String?
    var publicKey: String?
    
    init(attestation: String?, csr: String?, publicKey: String?) {
        self.attestationField = attestation
        self.csr = csr
        self.publicKey = publicKey
    }
    
    func toDict() -> [String: Any] {
        var retVal = [String: Any]()
        if let attestationField = self.attestationField {
            retVal["attestation_field"] = attestationField
        }
        if let publicKey = self.publicKey {
            retVal["public_key"] = publicKey
        }
        if let csr = self.csr {
            retVal["csr"] = csr
        }

        return retVal
    }
}
