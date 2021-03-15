//
//  PkiDataParameters+Extension.swift
//  transactId-library-ios
//
//  Created by Developer on 25.02.2021.
//

import Foundation

extension PkiDataParameters {
    
    func toMessageAttestation(requireSignature: Bool) -> MessageAttestation {
        var messageAttestationUnsigned = MessageAttestation()
        
        messageAttestationUnsigned.pkiType = self.type.rawValue
        messageAttestationUnsigned.pkiData = self.certificatePem?.data(using: .utf8) ?? Data()
        messageAttestationUnsigned.signature = "".data(using: .utf8) ?? Data()
        if let attestation = self.attestation {
            messageAttestationUnsigned.attestation = MessageAttestationType(rawValue: attestation.rawValue) ?? MessageAttestationType()
        }
        
        if (requireSignature && self.type == .x509sha256) {
            do {
                var messageAttestationSigned = MessageAttestation()
                
                let serializedData = try messageAttestationUnsigned.serializedData()
                if let privateKey = self.privateKeyPem {
                    if let signature = CryptoModule().sign(privateKeyPem: privateKey, message: serializedData.base64EncodedString()) {
                        try messageAttestationSigned.merge(serializedData: serializedData)
                        messageAttestationSigned.signature = signature
                    }
                }
                return messageAttestationSigned
                
            } catch let exception {
                print("Require Signature Exception: \(exception)")
            }
        }
        
        return messageAttestationUnsigned
    }
}
