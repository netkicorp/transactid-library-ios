//
//  ExceptionMessages.swift
//  transactId-library-ios
//
//  Created by Developer on 09.02.2021.
//

import Foundation

public struct ExceptionMessages {

    public static let ownersValidationEmptyError = "There should be at least one %@ for this message"
    public static let ownersValidationNoPrimaryOwner = "There should be one primary %@"
    public static let ownersValidationMultiplePrimaryOwners = "There can be only one primary %@"
    public static let certificateValidationCertificateExpired = "The certificate is expired"
    public static let certificateValidationCertificateNotYetValid = "The certificate is not yet valid"
    public static let certificateValidationCertificateRevoked = "The certificate is revoked by CRL"
    public static let certificateValidationNotCorrectCertificateError = "Certificate: %@, is not a valid %@ certificate"
    public static let encryptionMissingRecipientKeysError = "To encrypt the message you need to have the recipient's public key in your RecipientParameters.EncryptionParameters object."
    public static let encryptionMissingSenderKeysError = "To encrypt the message you need to have the sender's public/private keys in your SenderParameters.EncryptionParameters object."
    public static let parseBinaryMessageInvalidInput = "Invalid object for message, error: %@"
    public static let decryptionMissingRecipientKeysError = "To decrypt the message you need to have the recipient's private key in your RecipientParameters.EncryptionParameters object."
    public static let encryptionInvalidError = "Unable to decrypt the message with the given keys"
    public static let signatureValidationInvalidSenderSignature = "Sender signature is not valid"
    public static let certificateValidationInvalidSenderCertificateCA = "Sender certificate does not belong to any trusted CA"
    public static let certificateValidationInvalidSenderCertificateEV = "The certificate is not a valid EV certificate."
    public static let certificateValidationInvalidOwnerCertificateCA = "Owner certificate for attestation does not belong to any trusted CA"
    public static let signatureValidationInvalidOwnerSignature = "Owner signature is not valid for attestation"




}
