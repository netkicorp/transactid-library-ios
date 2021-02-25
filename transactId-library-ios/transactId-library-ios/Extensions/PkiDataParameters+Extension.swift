//
//  PkiDataParameters+Extension.swift
//  transactId-library-ios
//
//  Created by Developer on 25.02.2021.
//

import Foundation

extension PkiDataParameters {
    
    func toMessageAttestation(requireSignature: Bool) -> MessageAttestation{
        var messageAttestationUnsigned = MessageAttestation()
        
        messageAttestationUnsigned.pkiType = self.type.rawValue
        messageAttestationUnsigned.pkiData = self.certificatePem?.data(using: .utf8) ?? Data()
        messageAttestationUnsigned.signature = "".data(using: .utf8) ?? Data()
        if let attestation = self.attestation {
            messageAttestationUnsigned.attestation = MessageAttestationType(rawValue: attestation.rawValue) ?? MessageAttestationType()
        }
        
//        messageAttestationUnsigned.serializedData()
//        messageAttestationUnsigned.merge(serializedData: <#T##Data#>)
        return messageAttestationUnsigned
    }
}
