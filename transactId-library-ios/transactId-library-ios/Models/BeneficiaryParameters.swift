//
//  BeneficiaryParameters.swift
//  transactId-library-ios
//
//  Created by Developer on 09.02.2021.
//

import Foundation

public class BeneficiaryParameters : OwnerParameters {
    
    /**
     * True if this is the primary account owner for this transaction, there can be only one primary owner per transaction.
     */
    public var isPrimaryForTransaction: Bool = true
    
    /**
     * All the PkiData associated to the beneficiary.
     */
    public var pkiDataParametersSets: Array<PkiDataParameters>? = nil
    
    public init(isPrimaryForTransaction: Bool, pkiDataParametersSets: Array<PkiDataParameters>? = nil) {
        self.isPrimaryForTransaction = isPrimaryForTransaction
        self.pkiDataParametersSets = pkiDataParametersSets
    }
}
