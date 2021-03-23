//
//  ExceptionMessages.swift
//  transactId-library-ios
//
//  Created by Developer on 09.02.2021.
//

import Foundation

struct ExceptionMessages {

    static let OWNERS_VALIDATION_EMPTY_ERROR = "There should be at least one %@ for this message"
    static let OWNERS_VALIDATION_NO_PRIMARY_OWNER = "There should be one primary %@"
    static let OWNERS_VALIDATION_MULTIPLE_PRIMARY_OWNERS = "There can be only one primary %@"
    static let CERTIFICATE_VALIDATION_CERTIFICATE_EXPIRED = "The certificate is expired"
    static let CERTIFICATE_VALIDATION_CERTIFICATE_NOT_YET_VALID = "The certificate is not yet valid"
    static let CERTIFICATE_VALIDATION_CERTIFICATE_REVOKED = "The certificate is revoked by CRL"
    static let CERTIFICATE_VALIDATION_NOT_CORRECT_CERTIFICATE_ERROR = "Certificate: %@, is not a valid %@ certificate"
    static let encryptionMissingRecipientKeysError = "To encrypt the message you need to have the recipient's public key in your RecipientParameters.EncryptionParameters object."
    static let encryptionMissingSenderKeysError = "To encrypt the message you need to have the sender's public/private keys in your SenderParameters.EncryptionParameters object."
    static let parseBinaryMessageInvalidInput = "Invalid object for message, error: %@"
    static let decryptionMissingRecipientKeysError = "To decrypt the message you need to have the recipient's private key in your RecipientParameters.EncryptionParameters object."
    static let encryptionInvalidError = "Unable to decrypt the message with the given keys"

}
