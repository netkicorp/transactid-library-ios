//
//  Beneficiary+Extension.swift
//  transactId-library-ios
//
//  Created by Developer on 15.04.2021.
//

import Foundation

extension Beneficiary {
    
    /**
     * Transform Beneficiary to MessageBeneficiary object.
     *
     * @return MessageBeneficiary.
     */
    func toMessageBeneficiary() -> MessageBeneficiary {

        var messageBeneficiary = MessageBeneficiary()
        
        messageBeneficiary.isPrimaryForTransaction = self.isPrimaryForTransaction
        
        self.pkiDataSets?.forEach({ (pkiData) in
            var messageAttestation = MessageAttestation()
            
            if let attestation = pkiData.attestation {
                messageAttestation.attestation = MessageAttestationType(rawValue: attestation.rawValue) ?? MessageAttestationType()
            }
    
            messageAttestation.pkiData = pkiData.certificate.toByteString()
            if let pkiType = pkiData.pkiType {
                messageAttestation.pkiType = pkiType.rawValue
            }
            messageAttestation.signature = pkiData.signature.toByteString()
            
            messageBeneficiary.addAttestation(attestation: messageAttestation)
            
        })
        
        return messageBeneficiary
    }
}
