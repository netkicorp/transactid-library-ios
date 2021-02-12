//
//  OriginatorParameters.swift
//  transactId-library-ios
//
//  Created by Developer on 09.02.2021.
//

import Foundation

class OriginatorParameters : OwnerParameters {    
    
    var isPrimaryForTransaction: Bool = true
    
    var pkiDataParametersSets: Array<PkiDataParameters>? = nil
}
