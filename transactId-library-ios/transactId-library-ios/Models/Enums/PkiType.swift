//
//  PkiType.swift
//  transactId-library-ios
//
//  Created by Developer on 09.02.2021.
//

import Foundation

/**
 * Supported Pki types.
 */
public enum PkiType: String {
    
    /**
     * No Pki type defined, there won't be signature created.
     */
    case none = "none"
    
    /**
     * Pki type X509, the signature will use SHA256 algorithm.
     */
    case x509sha256 = "x509+sha256"
    
}
