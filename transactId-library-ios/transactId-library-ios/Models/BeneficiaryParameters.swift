//
//  BeneficiaryParameters.swift
//  transactId-library-ios
//
//  Created by Developer on 09.02.2021.
//

import Foundation

class BeneficiaryParameters : OwnerParameters {
    
    /**
     * True if this is the primary account owner for this transaction, there can be only one primary owner per transaction.
     */
    var isPrimaryForTransaction: Bool = true
    
    /**
     * All the PkiData associated to the beneficiary.
     */
    var pkiDataParametersSets: Array<PkiDataParameters>? = nil
}
