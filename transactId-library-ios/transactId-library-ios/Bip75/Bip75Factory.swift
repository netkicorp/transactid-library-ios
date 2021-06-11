//
//  Bip75Factory.swift
//  transactId-library-ios
//
//  Created by Developer on 09.02.2021.
//

import Foundation

/**
 * Factory to generate Bip75 instance.
 */

class Bip75Factory {
    
    private static var sharedBip75factory = Bip75Factory()
    
    private init () {}
    
    class func shared() -> Bip75Factory {
        return sharedBip75factory
    }
    
    /**
     * Get an instance of Bip75.
     * @param trustStore is a security directory that contains the valid certificate chains.
     * @param authorizationKey pass this parameter if address information will be required.
     * @return Bip75 instance.
     */
    func getInstance(trustStore: TrustStore? = nil, autorizationKey: String? = nil, developmentMode: Bool = false) -> Bip75 {
        
        let certificateValidator: CertificateValidator = CertificateValidator(trustStore: trustStore, developmentMode: developmentMode)
        
        let addressInformationRepo = MerkleRepo(authorizationKey: autorizationKey ?? "")
        
        let addressInformationService = AddressInformationServiceNetki(addressInformationRepo: addressInformationRepo)
        
        let bip75Service: Bip75Service = Bip75ServiceNetki(certificateValidator: certificateValidator, addressInformationService: addressInformationService)

        return Bip75Netki(bip75Service: bip75Service)
    }
}
