//
//  SettingsProvider.swift
//  transactId-library-ios
//
//  Created by Developer on 08.02.2021.
//

import Foundation
class SettingsProvider {
    
    static var pearlApiBaseURL: String {
        get {
            return "https://dev-kyc.myverify.info/"
        }
    }
    
    static var amberApiBaseURL: String {
        get {
            return "https://amber.myverify.io/"
        }
    }
    
}
