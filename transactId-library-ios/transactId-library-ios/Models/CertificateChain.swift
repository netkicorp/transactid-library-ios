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
    
    let rootCertificate: String

    let intermediateCertificates: Array<String>
    
    init(rootCertificate: String, intermediateCertificates: Array<String>) {
        self.rootCertificate = rootCertificate
        self.intermediateCertificates = intermediateCertificates
    }
}
