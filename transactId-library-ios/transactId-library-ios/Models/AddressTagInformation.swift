//
//  AddressTagInformation.swift
//  transactId-library-ios
//
//  Created by Developer on 09.02.2021.
//

import Foundation

class AddressTagInformation {
    
    /**
     * Entity type.
     */
    var tagNameVerbose: String? = nil
    
    /**
     * Entity subtype.
     */
    var tagSubtypeVerbose: String? = nil
    
    /**
     * Entity name.
     */
    var tagTypeVerbose: String? = nil
    
    /**
     * Value sent by entity in this transaction.
     */
    var totalValueUsd: String? = nil
}
