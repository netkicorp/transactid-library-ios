//
//  LocalStoreProvider.swift
//  transactId-library-ios
//
//  Created by Developer on 03.02.2021.
//

import Foundation

class LocalStoreProvider: TrustStore {
    
    func retriveAllCertificates() -> Array<String>? {
        return []
    }
    
    
    private let kPublicKeyFileName = "public_key.pem"
    private let kPrivateKeyFileName = "private_key.pem"
    private let kCSRFileName = "csr.pem"
    private let kCertificateFileName = "certificate.pem"

    private func applicationocumentDirectory() -> String? {
        if let documentDirectory = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).last?.absoluteString {
            return documentDirectory.replacingOccurrences(of: "file://", with: "")
        }
        return nil
    }
    
    private func publicKeyPath() -> String? {
        if let applicationDirectory = self.applicationocumentDirectory() {
            return applicationDirectory.appending(kPublicKeyFileName)
        }
        return nil
    }
    
    private func privateKeyPath() -> String? {
        if let applicationDirectory = self.applicationocumentDirectory() {
            return applicationDirectory.appending(kPrivateKeyFileName)
        }
        return nil
    }
    
    private func csrPath() -> String? {
        if let applicationDirectory = self.applicationocumentDirectory() {
            return applicationDirectory.appending(kCSRFileName)
        }
        return nil
    }
    
    private func certificatePath() -> String? {
        if let applicationDirectory = self.applicationocumentDirectory() {
            return applicationDirectory.appending(kCertificateFileName)
        }
        return nil
    }
    
    func storePublicKey(publicKey: String) {
        if let publicKeyData = publicKey.data(using: .utf8) {
            if let path = self.publicKeyPath() {
                do {
                    try publicKeyData.write(to: URL(fileURLWithPath: path))
                } catch {
                    print(error)
                }
            }
        }
    }
    
    func retrivePublicKey() -> String? {
        var result: String? = nil
        if let path = self.publicKeyPath() {
            do {
                let keyData = try Data(contentsOf: URL(fileURLWithPath: path))
                result = String(data: keyData, encoding: .utf8)
            } catch {
                print(error)
            }
        }
        return result
    }
    
    func storePrivateKey(privateKey: String) {
        if let privateKeyData = privateKey.data(using: .utf8) {
            if let path = self.privateKeyPath() {
                do {
                    try privateKeyData.write(to: URL(fileURLWithPath: path))
                } catch {
                    print(error)
                }
            }
        }
    }
    
    func retrivePrivateKey() -> String? {
        var result: String? = nil
        if let path = self.privateKeyPath() {
            do {
                let keyData = try Data(contentsOf: URL(fileURLWithPath: path))
                result = String(data: keyData, encoding: .utf8)
            } catch {
                print(error)
            }
        }
        return result
    }
    
    func storeCertificate(certificate: String) {
        if let certificateData = certificate.data(using: .utf8) {
            if let path = self.certificatePath() {
                do {
                    try certificateData.write(to: URL(fileURLWithPath: path))
                } catch {
                    print(error)
                }
            }
        }
    }
    
    func retriveCertificate() -> String? {
        var result: String? = nil
        if let path = self.certificatePath() {
            do {
                let keyData = try Data(contentsOf: URL(fileURLWithPath: path))
                result = String(data: keyData, encoding: .utf8)
            } catch {
                print(error)
            }
        }
        return result
    }
}
