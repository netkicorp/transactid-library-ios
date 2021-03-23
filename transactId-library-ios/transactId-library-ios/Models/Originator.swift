//
//  Originator.swift
//  transactId-library-ios
//
//  Created by Developer on 23.03.2021.
//

import Foundation

class Originator : Owner {
    
    /**
     * True if this is the primary account owner for this transaction, there can be only one primary owner per transaction.
     */
    var isPrimaryForTransaction: Bool = true
    
    /**
     * All the PkiData associated to the originator.
     */
    var pkiDataSets: Array<PkiData>? = nil
    
}
