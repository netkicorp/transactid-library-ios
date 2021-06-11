//
//  AddressTagInformation.swift
//  transactId-library-ios
//
//  Created by Developer on 09.02.2021.
//

import Foundation

public class AddressTagInformation {
    
    /**
     * Entity type.
     */
    public var tagNameVerbose: String? = nil
    
    /**
     * Entity subtype.
     */
    public var tagSubtypeVerbose: String? = nil
    
    /**
     * Entity name.
     */
    public var tagTypeVerbose: String? = nil
    
    /**
     * Value sent by entity in this transaction.
     */
    public var totalValueUsd: String? = nil
}
