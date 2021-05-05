//
//  Owner.swift
//  transactId-library-ios
//
//  Created by Developer on 23.03.2021.
//

import Foundation

/**
 * Data of the owner of the account.
 */

protocol Owner {
        
    /**
     * True if this is the primary account owner for this transaction, there can be only one primary owner per transaction.
     */
    var isPrimaryForTransaction: Bool { get set }
    
    /**
     * All the PkiData associated to the Owner.
     */
    var pkiDataSets: Array<PkiData>? { get set }
    
}
