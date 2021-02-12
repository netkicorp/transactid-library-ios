//
//  CertificateValidator.swift
//  transactId-library-ios
//
//  Created by Developer on 09.02.2021.
//

import Foundation

/**
 * Class with methods to validate things related with certificates.
 */

class CertificateValidator {
    
    private let trustStore: TrustStore

    private let developmentMode: Bool
    
    private let openSSLTools = OpenSSLTools()
    
    init(trustStore: TrustStore, developmentMode: Bool = false) {
        self.trustStore = trustStore
        self.developmentMode = developmentMode
    }
    
    private func storeCertificate(certificate: String) {
        self.trustStore.storeCertificate(certificate: certificate)
    }
    
    /**
     * Method to validate if a certificates is valid.
     *
     * @param certificate certificate to validate, could be a client certificate including its own certificates chain.
     * @return true if the client certificate is valid.
     */
        
    func validateCertificate(certificate: String) -> Bool {
        return false
    }
    
    
    /**
     * Extract client certificate from a array of certificates.
     *
     * @param certificates including the client certificate.
     * @return Client certificate.
     */
    private func getClientCertificate(certificates: Array<String>) -> String? {
        return certificates.first(where: { self.isClientCertificate(certificate: $0) })
    }
    
    /**
     * Extract intermediate certificates from a array of certificates.
     *
     * @param certificates including the intermediate certificates.
     * @return array of intermediate certificates.
     */
    private func getIntermediateCertificates(certificates: Array<String>) -> Array<String>? {
        return certificates.filter { self.isIntermediateCertificate(certificate: $0) }
    }
    
    /**
     * Validate if a X509Certificate is self signed or not.
     */
    
    func isSigned(certificate: String) -> Bool {
        return openSSLTools.isSigned(certificate)
    }
    
    /**
     * Determine if a X509Certificate is root certificate.
     */
    
    func isRootCertificate(certificate: String) -> Bool {
        return openSSLTools.isRootCertificate(certificate)
    }
    
    /**
     * Determine if a X509Certificate is intermediate certificate.
     */
    
    func isIntermediateCertificate(certificate: String) -> Bool {
        return openSSLTools.isIntermediateCertificate(certificate)
    }
    
    /**
     * Determine if a X509Certificate is client certificate.
     */
    
    func isClientCertificate(certificate: String) -> Bool {
        return openSSLTools.isClientCertificate(certificate)
    }
}
