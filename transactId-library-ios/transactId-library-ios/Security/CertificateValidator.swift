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
    
    private let trustStore: TrustStore?
    
    private let developmentMode: Bool
    
    private let openSSLTools = OpenSSLTools()
    
    init(trustStore: TrustStore? = nil, developmentMode: Bool = false) {
        self.trustStore = trustStore
        self.developmentMode = developmentMode
    }
    
    private func storeCertificate(certificate: String) {
        self.trustStore?.storeCertificate(certificate: certificate)
    }
    
    /**
     * Method to validate if a certificates is valid.
     *
     * @param clientCertificatesPem certificate to validate, could be a client certificate including its own certificates chain.
     * @return true if the client certificate is valid.
     * @exception InvalidCertificateException if there is a problem with the certificates.
     * @exception InvalidCertificateChainException if there is a problem with the certificates chain.
     */
    
    func validateCertificate(clientCertificatesPem: String) throws -> Bool {
        
        guard try self.validateExpiration(clientCertificatePem: clientCertificatesPem) else {
            return false
        }
        
        guard try self.validateCertificateRevocation(clientCertificatePem: clientCertificatesPem) else {
            return false
        }
        
        guard try self.validateCertificateChain(clientCertificatesPem: clientCertificatesPem) else {
            return false
        }
        
        return true
    }
    
    /**
     * Method to validate if a chain of certificates is valid.
     *
     * @param clientCertificatesPem certificate to validate.
     * @return true if the chain is valid.
     * @exception InvalidCertificateException if there is a problem with the certificates.
     */
    
    func validateCertificateChain(clientCertificatesPem: String) throws -> Bool {
        
        return true;
    }
    
    /**
     * Method to validateExpiration if a certificates is valid.
     *
     * @param clientCertificatePem certificate to validate.
     * @return true if the certificate is valid.
     * @exception InvalidCertificateException if there is a problem with the certificates.
     */
    func validateExpiration(clientCertificatePem: String) throws -> Bool {
        if let certificates = self.pemCertificatesToArray(certificatesPem: clientCertificatePem) {
            if let clientCertificate = self.getClientCertificate(certificates: certificates) {
                if !self.openSSLTools.validateNot(beforeExpirationCertificate: clientCertificate) {
                    throw Exception.InvalidCertificateException(ExceptionMessages.CERTIFICATE_VALIDATION_CERTIFICATE_NOT_YET_VALID)
                }
                
                if !self.openSSLTools.validateNot(afterExpirationCertificate: clientCertificate) {
                    throw Exception.InvalidCertificateException(ExceptionMessages.CERTIFICATE_VALIDATION_CERTIFICATE_EXPIRED)
                    
                }
                return true
            }
        }
        return false
    }
    
    /**
     * Method to validate if a certificates is not revoked.
     *
     * @param clientCertificatesPem certificate to validate.
     * @return true if the certificate is not revoked.
     * @exception InvalidCertificateException if the certificate is revoked.
     */
    func validateCertificateRevocation(clientCertificatePem: String) throws -> Bool {
        if let certificates = self.pemCertificatesToArray(certificatesPem: clientCertificatePem) {
            if let clientCertificate = self.getClientCertificate(certificates: certificates) {
                if let distributionPoints = self.getCrlDistributionPoints(clientCertificatePem: clientCertificate) {
                    try distributionPoints.forEach({ (distributionPoint) in
                        if let crl = distributionPoint {
                            if (self.isRevoked(crl: crl, certificate: clientCertificate)) {
                                throw Exception.InvalidCertificateException(ExceptionMessages.CERTIFICATE_VALIDATION_CERTIFICATE_REVOKED)
                            }
                        }
                    })
                }
            }
        }
        return true
    }
    
    /**
     * Extracts all CRL distribution point URLs from the
     * "CRL Distribution Point" extension in a X.509 certificate. If CRL
     * distribution point extension is unavailable, returns an empty list.
     */
    
    private func getCrlDistributionPoints(clientCertificatePem: String) -> Array<String?>? {
        if let crls = self.openSSLTools.getCRLDistributionPoints(clientCertificatePem) as NSArray as? [String] {
            return crls
        }
        return nil
    }
    
    /**
     * Convert certificates in PEM format to Object.
     *
     * @param certificatesPem string.
     * @return List of certificates.
     */
    private func pemCertificatesToArray(certificatesPem: String) -> Array<String>? {
        if let certificates = self.openSSLTools.pem(toCertificatesArray: certificatesPem) as NSArray as? [String] {
            return certificates
        }
        return nil
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
        return self.openSSLTools.isSigned(certificate)
    }
    
    /**
     * Determine if a X509Certificate is root certificate.
     */
    
    func isRootCertificate(certificate: String) -> Bool {
        return self.openSSLTools.isRootCertificate(certificate)
    }
    
    /**
     * Determine if a X509Certificate is intermediate certificate.
     */
    
    func isIntermediateCertificate(certificate: String) -> Bool {
        return self.openSSLTools.isIntermediateCertificate(certificate)
    }
    
    /**
     * Determine if a X509Certificate is client certificate.
     */
    
    func isClientCertificate(certificate: String) -> Bool {
        return self.openSSLTools.isClientCertificate(certificate)
    }
    
    func isRevoked(crl: String, certificate: String) -> Bool {
        return self.openSSLTools.isRevoked(crl, certificate: certificate)
    }
    
}
