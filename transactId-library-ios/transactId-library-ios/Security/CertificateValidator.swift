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
        
        guard try self.validateCertificateChain(clientCertificatesPem: clientCertificatesPem) else {
            return false
        }
        
        guard try self.validateExpiration(clientCertificatePem: clientCertificatesPem) else {
            return false
        }
        
        guard try self.validateCertificateRevocation(clientCertificatePem: clientCertificatesPem) else {
            return false
        }
        
        return true
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
                    throw Exception.InvalidCertificateException(ExceptionMessages.certificateValidationCertificateNotYetValid)
                }
                
                if !self.openSSLTools.validateNot(afterExpirationCertificate: clientCertificate) {
                    throw Exception.InvalidCertificateException(ExceptionMessages.certificateValidationCertificateExpired)
                    
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
                                throw Exception.InvalidCertificateException(ExceptionMessages.certificateValidationCertificateRevoked)
                            }
                        }
                    })
                }
            }
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
        if let trustStore = self.trustStore {
            if let certificates = trustStore.retriveAllCertificates() {
                let certificateChains = self.convertToCertificateChains(certificates: certificates)
                return try self.validateCertificateChain(clientCertificatesPem: clientCertificatesPem, certificateChains: certificateChains)
            }
        }
        
        return false;
    }
    
    /**
     * Method to validate if a chain of certificates is valid.
     *
     * @param clientCertificatesPem chain of certificates to validate.
     * @param certificateChains list of all certificate chains to use to validate the client certificate.
     * @return true if the chain is valid.
     * @exception InvalidCertificateException if there is a problem with the certificates.
     */
    
    func validateCertificateChain(clientCertificatesPem: String, certificateChains: Array<CertificateChain>) throws -> Bool {
        
        if let certificates = self.pemCertificatesToArray(certificatesPem: clientCertificatesPem) {
            if let clientCertificate = self.getClientCertificate(certificates: certificates),
               let intermediateCertificates = self.getIntermediateCertificates(certificates: certificates) {
                
                try self.validateCertificatesInput(clientCertificate: clientCertificate,
                                               intermediateCertificates: intermediateCertificates,
                                               certificateChains: certificateChains)
                
                return true
            }
        }
        
        return false;
    }
    
    private func validateCertificatesInput(clientCertificate: String, intermediateCertificates: Array<String>, certificateChains: Array<CertificateChain>) throws {
        
        if !self.isClientCertificate(certificate: clientCertificate) {
            throw Exception.InvalidOwnersException(String(format: ExceptionMessages.certificateValidationNotCorrectCertificateError, clientCertificate, "Client"))
        }
        
        try intermediateCertificates.forEach { (intermediateCertificate) in
            if !self.isIntermediateCertificate(certificate: intermediateCertificate) {
                throw Exception.InvalidOwnersException(String(format: ExceptionMessages.certificateValidationNotCorrectCertificateError, intermediateCertificate, "Intermediate"))
            }
        }
        
        try certificateChains.forEach { (certificateChain) in
            let rootCertificate = certificateChain.rootCertificate
            
            if !self.isRootCertificate(certificate: rootCertificate) {
                throw Exception.InvalidOwnersException(String(format: ExceptionMessages.certificateValidationNotCorrectCertificateError, rootCertificate, "Root"))
            }
            
            try certificateChain.intermediateCertificates.forEach { (certificate) in
                if !self.isIntermediateCertificate(certificate: certificate) {
                    throw Exception.InvalidOwnersException(String(format: ExceptionMessages.certificateValidationNotCorrectCertificateError, certificate, "Intermediate"))
                }
            }
        }
    }
    
    /**
     * Extracts all CRL distribution point URLs from the
     * "CRL Distribution Point" extension in a X.509 certificate. If CRL
     * distribution point extension is unavailable, returns an empty list.
     */
    
    func getCrlDistributionPoints(clientCertificatePem: String) -> Array<String?>? {
        if let crls = self.openSSLTools.getCRLDistributionPoints(clientCertificatePem) as NSArray as? [String] {
            return crls
        }
        return nil
    }
    
    private func convertToCertificateChains(certificates: Array<String>) -> Array<CertificateChain> {
        var certificateChains: Array<CertificateChain> = []
        
        certificates.forEach { (certificatePem) in
            
            if let chain = self.pemCertificatesToArray(certificatesPem: certificatePem) {
                
                if let rootCertificate = chain.first(where: { self.isSigned(certificate: $0) }) {
                    let intermediateCertificates = chain.filter({ !self.isSigned(certificate: $0) })
                    
                    certificateChains.append(CertificateChain(rootCertificate: rootCertificate,
                                                              intermediateCertificates: intermediateCertificates))
                }
            }
        }
        return certificateChains
    }
    
    /**
     * Convert certificates in PEM format to Array of PEM.
     *
     * @param certificatesPem string.
     * @return Array of PEM certificates.
     */
    func pemCertificatesToArray(certificatesPem: String) -> Array<String>? {
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
    func getClientCertificate(certificates: Array<String>) -> String? {
        return certificates.first(where: { self.isClientCertificate(certificate: $0) })
    }
    
    /**
     * Extract intermediate certificates from a array of certificates.
     *
     * @param certificates including the intermediate certificates.
     * @return array of intermediate certificates.
     */
    func getIntermediateCertificates(certificates: Array<String>) -> Array<String>? {
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
     * Determine is client certificate.
     */
    
    func isClientCertificate(certificate: String) -> Bool {
        return self.openSSLTools.isClientCertificate(certificate)
    }
    
    func isRevoked(crl: String, certificate: String) -> Bool {
        return self.openSSLTools.isRevoked(crl, certificate: certificate)
    }
    
    /**
     * Method to validate if a certificates is an EV cert.
     *
     * @param clientCertificatesPem certificate to validate.
     * @return true if the certificate is EV.
     */
    
    func isEvCertificate(clientCertificatesPem: String) -> Bool {
        if let certificates = self.pemCertificatesToArray(certificatesPem: clientCertificatesPem) {
            if let clientCertificate = self.getClientCertificate(certificates: certificates) {
                return openSSLTools.isEvCertificate(clientCertificate)
            }
        }
        return false
    }
    
}
