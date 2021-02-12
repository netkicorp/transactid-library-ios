//
//  Array<OwnerParameters>+Extension.swift
//  transactId-library-ios
//
//  Created by Developer on 09.02.2021.
//

import Foundation

extension Array where Element : OwnerParameters  {
    
    func validate(required: Bool, ownerType: OwnerType) throws {
        if (required && self.isEmpty) {
            throw Exception.InvalidOwnersException(String(format: ExceptionMessages.OWNERS_VALIDATION_EMPTY_ERROR, ownerType.rawValue))
        } else if (!required && self.isEmpty) {
            return
        }
        
        let numberOfPrimaryOwners = self.filter{ $0.isPrimaryForTransaction }.count
        
        if (numberOfPrimaryOwners == 0) {
            throw Exception.InvalidOwnersException(String(format: ExceptionMessages.OWNERS_VALIDATION_NO_PRIMARY_OWNER, ownerType.rawValue))
        }
        
        if (numberOfPrimaryOwners > 1) {
            throw Exception.InvalidOwnersException(String(format: ExceptionMessages.OWNERS_VALIDATION_MULTIPLE_PRIMARY_OWNERS, ownerType.rawValue))
        }
    }
}
