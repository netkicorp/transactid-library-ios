//
//  Messages.swift
//  transactId-library-ios
//
//  Created by Developer on 24.02.2021.
//

import Foundation
import SwiftProtobuf

public class Messages {
    
    public struct InvoiceRequest {
        
        public init() {}
        
        var _amount: UInt64? = nil
        var _pkiType: String? = nil
        var _pkiData: Data? = nil
        var _memo: String? = nil
        var _notificationURL: String? = nil
        var _signature: Data? = nil
        var _evCert: Data? = nil
        
        
        // SwiftProtobuf.Message conformance is added in an extension below. See the
        // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
        // methods supported on all messages.
        
        /// amount is integer-number-of-satoshis
        var amount: UInt64 {
            get { return _amount ?? 0 }
            set { _amount = newValue }
        }
        /// Returns true if `amount` has been explicitly set.
        var hasAmount: Bool { return self._amount != nil }
        /// Clears the value of `amount`. Subsequent reads from it will return its default value.
        mutating func clearAmount() { self._amount = nil }
        
        /// none / x509+sha256
        var pkiType: String {
            get { return _pkiType ?? "none" }
            set { _pkiType = newValue }
        }
        /// Returns true if `pkiType` has been explicitly set.
        var hasPkiType: Bool { return self._pkiType != nil }
        /// Clears the value of `pkiType`. Subsequent reads from it will return its default value.
        mutating func clearPkiType() { self._pkiType = nil }
        
        /// Depends on pki_type
        var pkiData: Data {
            get { return _pkiData ?? SwiftProtobuf.Internal.emptyData }
            set { _pkiData = newValue }
        }
        /// Returns true if `pkiData` has been explicitly set.
        var hasPkiData: Bool { return self._pkiData != nil }
        /// Clears the value of `pkiData`. Subsequent reads from it will return its default value.
        mutating func clearPkiData() { self._pkiData = nil }
        
        /// Human-readable description of invoice request for the receiver
        var memo: String {
            get { return _memo ?? String() }
            set { _memo = newValue }
        }
        /// Returns true if `memo` has been explicitly set.
        var hasMemo: Bool { return self._memo != nil }
        /// Clears the value of `memo`. Subsequent reads from it will return its default value.
        mutating func clearMemo() { self._memo = nil }
        
        /// URL to notify on EncryptedPaymentRequest ready
        var notificationURL: String {
            get { return _notificationURL ?? String() }
            set { _notificationURL = newValue }
        }
        /// Returns true if `notificationURL` has been explicitly set.
        var hasNotificationURL: Bool { return self._notificationURL != nil }
        /// Clears the value of `notificationURL`. Subsequent reads from it will return its default value.
        mutating func clearNotificationURL() {self._notificationURL = nil}
        
        /// PKI-dependent signature
        var signature: Data {
            get { return _signature ?? SwiftProtobuf.Internal.emptyData }
            set { _signature = newValue }
        }
        /// Returns true if `signature` has been explicitly set.
        var hasSignature: Bool {return self._signature != nil}
        /// Clears the value of `signature`. Subsequent reads from it will return its default value.
        mutating func clearSignature() { self._signature = nil }
        
        /// PKI-dependent evCert
        var evCert: Data {
            get { return _evCert ?? SwiftProtobuf.Internal.emptyData }
            set { _evCert = newValue }
        }
        /// Returns true if `signature` has been explicitly set.
        var hasEvCert: Bool {return self._evCert != nil}
        /// Clears the value of `signature`. Subsequent reads from it will return its default value.
        mutating func clearEvCert() { self._evCert = nil }
        
        public var unknownFields = SwiftProtobuf.UnknownStorage()
    }

}
