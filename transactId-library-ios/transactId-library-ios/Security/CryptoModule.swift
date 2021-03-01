//
//  CryptoModule.swift
//  transactId-library-ios
//
//  Created by Developer on 02.02.2021.
//

import Foundation

let PASSWORD = "QwErTyUi!"

class CryptoModule {
    
    init() { }
    
    func keygenParamsFromCsr(csrInfo: [Csr]) -> OpenSSLKeyGenerationParams? {
        var firstName: String? = "Valentin",
            lastName: String? = "Kurakin",
            country: String? = "US",
            cn: String? = nil
        
        for csr in csrInfo {
            if csr.attestationField == "firstName" { firstName = csr.value }
            if csr.attestationField == "lastName" { lastName = csr.value }
            if csr.attestationField == "country" { country = csr.value }
        }
        
        if let firstName = firstName, let lastName = lastName { cn = "\(firstName) \(lastName)" }

        if let country = country, let cn = cn {
            return OpenSSLKeyGenerationParams(cn: cn,
                                              org: "Netki",
                                              country: country,
                                              state: " ",
                                              city: " ",
                                              passphrase: PASSWORD)
        }
        
        return nil
    }
    
    public func generateCertificateSigningRequestOpenSSL(csrInfo: [Csr]) -> OpenSSLKeyGenerateResult? {
        let openSSLTools = OpenSSLTools()
            
        if let keygenParams = self.keygenParamsFromCsr(csrInfo: csrInfo) {
            return openSSLTools.generateCertificate(keygenParams)
        }
    
        return nil
        
    }
    
   
    func sign(privateKeyPem: String, message: String) -> Data? {
        return OpenSSLTools().sign(privateKeyPem, message: message)
    }
    
    /**
     * Generate identifier for an specific message in ByteArray format
     */
    func generateIdentifier(message: Data) -> Data {
        let hash = OpenSSLTools().generateHash256(message.base64EncodedString())
        let epochTime = Int(Date().timeIntervalSince1970)
        return "\(hash)\(epochTime)".data(using: .utf8)!
        
    }
}
