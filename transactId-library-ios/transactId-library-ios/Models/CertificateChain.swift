//
//  CertificateChain.swift
//  transactId-library-ios
//
//  Created by Developer on 12.02.2021.
//

import Foundation

/**
 * Representation of a certificate chain in format PEM
 */
class CertificateChain {
    
    private (set) var rootCertificate: String? = nil
    private (set) var intermediateCertificates: Array<String> = []
    
    init(rootCertificate: String, intermediateCertificates: Array<String>) {
        self.rootCertificate = rootCertificate
        self.intermediateCertificates = intermediateCertificates
    }
}
