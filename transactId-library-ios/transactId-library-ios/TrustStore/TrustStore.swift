//
//  TrustStore.swift
//  transactId-library-ios
//
//  Created by Developer on 08.02.2021.
//

import Foundation

public protocol TrustStore {
    
    func storePrivateKey(privateKey: String)
    
    func storePublicKey(publicKey: String)
    
    func storeCertificate(certificate: String)
    
    
    func retrivePrivateKey() -> String?
    
    func retrivePublicKey() -> String?
    
    func retriveCertificate() -> String?
}
