//
//  OwnerParameters.swift
//  transactId-library-ios
//
//  Created by Developer on 09.02.2021.
//

import Foundation

/**
 * Data of the owner of the account to be used to create a message.
 */
public protocol OwnerParameters {
    
    /**
     * True if this is the primary account owner for this transaction, there can be only one primary owner per transaction.
     */
    var isPrimaryForTransaction: Bool { get set }
    
    /**
     * All the PkiData associated to the Owner.
     */
    var pkiDataParametersSets: Array<PkiDataParameters>? { get set }
}
