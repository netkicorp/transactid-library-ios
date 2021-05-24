//
//  MerkleTags.swift
//  transactId-library-ios
//
//  Created by Developer on 24.05.2021.
//

import Foundation

class MerkleTags {
    var owner: MerkleTagInformation?
    var user: MerkleTagInformation?

    init(json: [String: Any]) {
        if let ownerJson = json["owner"] as? [String: Any] {
            self.owner = MerkleTagInformation(json: ownerJson)
        }
        
        if let userJson = json["user"] as? [String: Any] {
            self.user = MerkleTagInformation(json: userJson)
        }
    }
}

extension MerkleTags {
    func toAddressTags() -> AddressTags {
        let addressTags = AddressTags()
        addressTags.owner = self.owner?.toAddressTagInformation()
        addressTags.user = self.user?.toAddressTagInformation()
        return addressTags
    }
}
