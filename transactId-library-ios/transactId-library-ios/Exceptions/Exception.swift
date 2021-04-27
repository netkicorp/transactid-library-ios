//
//  Exception.swift
//  transactId-library-ios
//
//  Created by Developer on 09.02.2021.
//

import Foundation

public enum Exception : Error {
    case AddressProviderErrorException(String)
    case AddressProviderUnauthorizedException(String)
    case CertificateProviderException(String)
    case CertificateProviderUnauthorizedException(String)
    case EncryptionException(String)
    case InvalidCertificateChainException(String)
    case InvalidCertificateException(String)
    case InvalidOwnersException(String)
    case InvalidObjectException(String)
    case InvalidPrivateKeyException(String)
    case InvalidSignatureException(String)
    case KeyManagementFetchException(String)
    case KeyManagementStoreException(String)
    case ObjectNotFoundException(String)
    
}
