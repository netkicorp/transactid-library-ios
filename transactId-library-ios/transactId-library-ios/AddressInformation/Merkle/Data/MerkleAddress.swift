//
//  MerkleAddress.swift
//  transactId-library-ios
//
//  Created by Developer on 24.05.2021.
//

import Foundation

class MerkleAddress {
    
    var identifier: String?
    var balance: Double?
    var beneficiary: Array<MerkleTagInformation> = []
    var caseStatus: Int?
    var caseStatusVerbose: String?
    var currency: Int?
    var currencyVerbose: String?
    var earliestTransactionTime: String?
    var latestTransactionTime: String?
    var originator: Array<MerkleTagInformation> = []
    var riskLevel: Int?
    var riskLevelVerbose: String?
    var merkleTags: MerkleTags?
    var totalIncomingValue: String?
    var totalIncomingValueUsd: String?
    var totalOutgoingValue: String?
    var totalOutgoingValueUsd: String?
    var createdAt: String?
    var updatedAt: String?
    
    init (json: [String: Any]) {
        if let identifier = json["identifier"] as? String {
            self.identifier = identifier
        }
        
        if let balance = json["balance"] as? Double {
            self.balance = balance
        }
        
        if let beneficiaryJson = json["beneficiary"] as? Array<[String: Any]> {
            beneficiaryJson.forEach { (merkleTagInformationJson) in
                self.beneficiary.append(MerkleTagInformation(json: merkleTagInformationJson))
            }
        }
        
        if let caseStatus = json["case_status"] as? Int {
            self.caseStatus = caseStatus
        }
        
        if let caseStatusVerbose = json["case_status_verbose"] as? String {
            self.caseStatusVerbose = caseStatusVerbose
        }
        
        if let currency = json["currency"] as? Int {
            self.currency = currency
        }
        
        if let currencyVerbose = json["currency_verbose"] as? String {
            self.currencyVerbose = currencyVerbose
        }
        
        if let earliestTransactionTime = json["earliest_transaction_time"] as? String {
            self.earliestTransactionTime = earliestTransactionTime
        }
        
        if let latestTransactionTime = json["latest_transaction_time"] as? String {
            self.latestTransactionTime = latestTransactionTime
        }
        
        if let originatorJson = json["originator"] as? Array<[String: Any]> {
            originatorJson.forEach { (merkleTagInformationJson) in
                self.originator.append(MerkleTagInformation(json: merkleTagInformationJson))
            }
        }
        
        if let riskLevel = json["risk_level"] as? Int {
            self.riskLevel = riskLevel
        }
        
        if let riskLevelVerbose = json["risk_level_verbose"] as? String {
            self.riskLevelVerbose = riskLevelVerbose
        }
        
        if let merkleTagsJson = json["tags"] as? [String: Any] {
            self.merkleTags = MerkleTags(json: merkleTagsJson)
        }
            
        if let totalIncomingValue = json["total_incoming_value"] as? String {
            self.totalIncomingValue = totalIncomingValue
        }
        
        if let totalIncomingValueUsd = json["total_incoming_value_usd"] as? String {
            self.totalIncomingValueUsd = totalIncomingValueUsd
        }
        
        if let totalOutgoingValue = json["total_outgoing_value"] as? String {
            self.totalOutgoingValue = totalOutgoingValue
        }
        
        if let totalOutgoingValueUsd = json["total_outgoing_value_usd"] as? String {
            self.totalOutgoingValueUsd = totalOutgoingValueUsd
        }
        
        if let createdAt = json["created_at"] as? String {
            self.createdAt = createdAt
        }
        
        if let updatedAt = json["updated_at"] as? String {
            self.updatedAt = updatedAt
        }
        
    }
}

extension MerkleAddress {
    
    func toAddressInformation() -> AddressInformation {
        let addressInformation = AddressInformation()
        addressInformation.identifier = self.identifier
        addressInformation.balance = self.balance
        self.beneficiary.forEach { (merkleTagInformation) in
            addressInformation.beneficiary.append(merkleTagInformation.toAddressTagInformation())
        }
        addressInformation.caseStatus = self.caseStatus
        addressInformation.caseStatusVerbose = self.caseStatusVerbose
        addressInformation.currency = self.currency
        addressInformation.currencyVerbose = self.currencyVerbose
        addressInformation.earliestTransactionTime = self.earliestTransactionTime
        addressInformation.latestTransactionTime = self.latestTransactionTime        
        self.originator.forEach { (merkleTagInformation) in
            addressInformation.originator.append(merkleTagInformation.toAddressTagInformation())
        }
        addressInformation.riskLevel = self.riskLevel
        addressInformation.riskLevelVerbose = self.riskLevelVerbose
        addressInformation.tags = self.merkleTags?.toAddressTags()
        addressInformation.totalIncomingValue = self.totalIncomingValue
        addressInformation.totalIncomingValueUsd = self.totalIncomingValueUsd
        addressInformation.totalOutgoingValue = self.totalOutgoingValue
        addressInformation.totalOutgoingValueUsd = self.totalOutgoingValueUsd
        addressInformation.createdAt = self.createdAt
        addressInformation.updatedAt = self.updatedAt
        return addressInformation
    }
}
