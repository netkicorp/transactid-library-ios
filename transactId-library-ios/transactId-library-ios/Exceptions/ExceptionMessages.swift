//
//  ExceptionMessages.swift
//  transactId-library-ios
//
//  Created by Developer on 09.02.2021.
//

import Foundation

struct ExceptionMessages {

    static let OWNERS_VALIDATION_EMPTY_ERROR = "There should be at least one %s for this message"
    static let OWNERS_VALIDATION_NO_PRIMARY_OWNER = "There should be one primary %s"
    static let OWNERS_VALIDATION_MULTIPLE_PRIMARY_OWNERS = "There can be only one primary %s"
    static let CERTIFICATE_VALIDATION_CERTIFICATE_EXPIRED = "The certificate is expired"
    static let CERTIFICATE_VALIDATION_CERTIFICATE_NOT_YET_VALID = "The certificate is not yet valid"
    static let CERTIFICATE_VALIDATION_CERTIFICATE_REVOKED = "The certificate is revoked by CRL"




}
