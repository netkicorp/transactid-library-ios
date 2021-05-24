//
//  MerkleTagInformation.swift
//  transactId-library-ios
//
//  Created by Developer on 24.05.2021.
//

import Foundation

class MerkleTagInformation {
    
    var tagNameVerbose: String?
    var tagSubtypeVerbose: String?
    var tagTypeVerbose: String?
    var tagTotalValueUsd: String?

    
    init(json: [String: Any]) {
        if let tagNameVerbose = json["tag_name_verbose"] as? String {
            self.tagNameVerbose = tagNameVerbose
        }
        
        if let tagSubtypeVerbose = json["tag_subtype_verbose"] as? String {
            self.tagSubtypeVerbose = tagSubtypeVerbose
        }
        
        if let tagTypeVerbose = json["tag_type_verbose"] as? String {
            self.tagTypeVerbose = tagTypeVerbose
        }
        
        if let tagTotalValueUsd = json["total_value_usd"] as? String {
            self.tagTotalValueUsd = tagTotalValueUsd
        }
    }
}

extension MerkleTagInformation {
    
    func toAddressTagInformation() -> AddressTagInformation {
        let addressTagInformation = AddressTagInformation()
        addressTagInformation.tagNameVerbose = self.tagNameVerbose
        addressTagInformation.tagSubtypeVerbose = self.tagSubtypeVerbose
        addressTagInformation.tagTypeVerbose = self.tagTypeVerbose
        addressTagInformation.totalValueUsd = self.tagTotalValueUsd
        return addressTagInformation
        
    }
}
