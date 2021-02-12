//
//  KeyChainProvider.swift
//  transactId-library-ios
//
//  Created by Developer on 04.02.2021.
//

import Foundation

class KeyChainProvider : TrustStore {
    
    func storePublicKey(publicKey: String) {
        
        let base64Key = publicKey
            .replacingOccurrences(of: "-----BEGIN PUBLIC KEY-----", with: "")
            .replacingOccurrences(of: "-----END PUBLIC KEY-----", with: "")
            .replacingOccurrences(of: "\r", with: "")
            .replacingOccurrences(of: "\n", with: "")
            .replacingOccurrences(of: "\t", with: "")
            .replacingOccurrences(of: " ", with: "")
        
        if let base64KeyData = Data(base64Encoded: base64Key) {
            if let bundleIdentifier = Bundle.main.bundleIdentifier {
                if let tag = "\(bundleIdentifier).publicKey".data(using: .utf8) {
                    if let secKey = SecKeyCreateWithData(base64KeyData as NSData,
                                                         [kSecAttrKeyType: kSecAttrKeyTypeRSA,
                                                          kSecAttrKeyClass: kSecAttrKeyClassPublic] as NSDictionary, nil) {
                        
                        var query = [kSecClass as String: kSecClassKey,
                                     kSecAttrApplicationLabel as String: tag,
                                     kSecAttrAccessible as String: kSecAttrAccessibleWhenUnlocked] as [String: Any]
                        
                        var status = SecItemDelete(query as CFDictionary)
                        
                        query[kSecValueRef as String] = secKey
                        
                        status = SecItemAdd(query as CFDictionary, nil)
                        guard status == errSecSuccess else {
                            
                            if let err = SecCopyErrorMessageString(status, nil) {
                                print("Store Public Key failed: \(err)")
                            }
                            return;
                        }
                    }
                }
            }
        }
    }
    
    func retrivePublicKey() -> String? {
        
        if let bundleIdentifier = Bundle.main.bundleIdentifier {
            if let tag = "\(bundleIdentifier).publicKey".data(using: .utf8) {
                
                let query = [kSecClass as String: kSecClassKey,
                             kSecAttrApplicationLabel as String: tag,
                             kSecAttrKeyType as String: kSecAttrKeyTypeRSA,
                             kSecReturnRef as String: true] as [String: Any]
                
                var item: CFTypeRef?
                let status = SecItemCopyMatching(query as CFDictionary, &item)
                guard status == errSecSuccess else {
                    if let err = SecCopyErrorMessageString(status, nil) {
                        print("Retrive Public Key failed: \(err)")
                    }
                    return nil
                }
                let key = item as! SecKey
                
                var error:Unmanaged<CFError>?
                
                if let cfdata = SecKeyCopyExternalRepresentation(key, &error) {
                    let data: Data = cfdata as Data
                    
                    let base64String = data.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters).replacingOccurrences(of: "\r", with: "")
                    
                    return "-----BEGIN PUBLIC KEY-----\n" + base64String + "\n-----END PUBLIC KEY-----\n"
                }
            }
        }
        
        return nil
    }
    
    
    func storePrivateKey(privateKey: String) {
        
        let base64Key = privateKey
            .replacingOccurrences(of: "-----BEGIN RSA PRIVATE KEY-----", with: "")
            .replacingOccurrences(of: "-----END RSA PRIVATE KEY-----", with: "")
            .replacingOccurrences(of: "\r", with: "")
            .replacingOccurrences(of: "\n", with: "")
            .replacingOccurrences(of: "\t", with: "")
            .replacingOccurrences(of: " ", with: "")
        
        
        if let base64KeyData = Data(base64Encoded: base64Key) {
            if let bundleIdentifier = Bundle.main.bundleIdentifier {
                if let tag = "\(bundleIdentifier).privateKey".data(using: .utf8) {
                    var error:Unmanaged<CFError>?
                    
                    if let secKey = SecKeyCreateWithData(base64KeyData as NSData,
                                                         [kSecAttrKeyType: kSecAttrKeyTypeRSA,
                                                          kSecAttrKeyClass: kSecAttrKeyClassPrivate] as NSDictionary, &error) {
                        
                        var query = [kSecClass as String: kSecClassKey,
                                     kSecAttrApplicationLabel as String: tag,
                                     kSecAttrAccessible as String: kSecAttrAccessibleWhenUnlocked] as [String: Any]
                        
                        var status = SecItemDelete(query as CFDictionary)

                        query[kSecValueRef as String] = secKey

                        status = SecItemAdd(query as CFDictionary, nil)
                        guard status == errSecSuccess else {

                            if let err = SecCopyErrorMessageString(status, nil) {
                                print("Store Private failed: \(err)")
                            }
                            return;
                        }
                        
                    } else {
                        print("Store Private failed: \(String(describing: error))")
                        
                    }
                }
            }
        }
    }
    
    func retrivePrivateKey() -> String? {

        if let bundleIdentifier = Bundle.main.bundleIdentifier {
            if let tag = "\(bundleIdentifier).privateKey".data(using: .utf8) {
                
                let query = [kSecClass as String: kSecClassKey,
                             kSecAttrApplicationLabel as String: tag,
                             kSecAttrKeyType as String: kSecAttrKeyTypeRSA,
                             kSecReturnRef as String: true] as [String: Any]
                
                var item: CFTypeRef?
                let status = SecItemCopyMatching(query as CFDictionary, &item)
                guard status == errSecSuccess else {
                    if let err = SecCopyErrorMessageString(status, nil) {
                        print("Retrive Private Key failed: \(err)")
                    }
                    return nil
                }
                let key = item as! SecKey
                var error:Unmanaged<CFError>?
                
                if let cfdata = SecKeyCopyExternalRepresentation(key, &error) {
                    let data: Data = cfdata as Data
                    
                    let base64String = data.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters).replacingOccurrences(of: "\r", with: "")
                    
                    return "-----BEGIN RSA PRIVATE KEY-----\n" + base64String + "\n-----END RSA PRIVATE KEY-----\n"
                }
            }
        }
        
        return nil
        
    }
    
    func storeCertificate(certificate: String) {
        
        let base64 = certificate
            .replacingOccurrences(of: "-----BEGIN CERTIFICATE-----", with: "")
            .replacingOccurrences(of: "-----END CERTIFICATE-----", with: "")
            .replacingOccurrences(of: "\r", with: "")
            .replacingOccurrences(of: "\n", with: "")
            .replacingOccurrences(of: "\t", with: "")
            .replacingOccurrences(of: " ", with: "")
        
        if let base64Data = Data(base64Encoded: base64) {
            if let bundleIdentifier = Bundle.main.bundleIdentifier {
                if let tag = "\(bundleIdentifier).certificate".data(using: .utf8) {
                    
                    if let secCert = SecCertificateCreateWithData(nil, base64Data as CFData) {
                        
                    }
                }
            }
        }
    }
    
    func retriveCertificate() -> String? {
        return nil
    }
    
}
