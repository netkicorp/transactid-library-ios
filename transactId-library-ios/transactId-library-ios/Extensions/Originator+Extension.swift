//
//  Originator+Extension.swift
//  transactId-library-ios
//
//  Created by Developer on 15.04.2021.
//

import Foundation

extension Originator {
    
    /**
     * Transform Originator to MessageOriginator object.
     *
     * @return MessageOriginator.
     */
    
    func toMessageOriginator() -> MessageOriginator {
        var messageOriginator = MessageOriginator()
        
        messageOriginator.isPrimaryForTransaction = self.isPrimaryForTransaction
        
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
            
            messageOriginator.addAttestation(attestation: messageAttestation)
            
        })
        
        return messageOriginator
        
    }
    
}
