//
//  AddressInformation.swift
//  transactId-library-ios
//
//  Created by Developer on 09.02.2021.
//

import Foundation

/**
 * Detailed information about an address.
 */
public class AddressInformation {
    
    /**
     * Address.
     * If blank or empty, not information was found for this address.
     */
    public var identifier: String? = nil
    
    /**
     * Total amount in cryptocurrency available with address.
     */
    public var balance: Double? = 0.0
    
    /**
     * A list of entities who were beneficiaries in a transaction.
     */
    public var beneficiary: Array<AddressTagInformation> = []
    
    /**
     * Case status for transaction.
     */
    public var caseStatus: Int? = nil
    
    /**
     * Case status for transaction.
     */
    public var caseStatusVerbose: String? = nil
    
    /**
     * The currency code for the blockchain this address was searched on, [-1] if could not get the currency of the address.
     */
    public var currency: Int? = -1
    
    /**
     * The currency name for the blockchain this address was searched on.
     */
    public var currencyVerbose: String? = nil
    
    /**
     * Date on which address has made its first transaction.
     */
    public var earliestTransactionTime: String? = nil
    
    /**
     * Date on which address has made its last transaction.
     */
    public var latestTransactionTime: String? = nil
    
    /**
     * A list of entities who were originators in a transaction.
     */
    public var originator: Array<AddressTagInformation> = []
    
    /**
     * An integer indicating if this address is Low Risk [1], Medium Risk [2] or High Risk [3] address or if no risks were detected [0], [-1] if could not fetch the risk level.
     */
    public var riskLevel: Int? = -1
    
    /**
     * Indicates if this address is Low Risk, Medium Risk , High Risk or if no risks were detected.
     */
    public var riskLevelVerbose: String? = nil
    
    /**
     * Information about the owner and user.
     */
    public var tags: AddressTags? = nil
    
    /**
     * Total amount received by the address in cryptocurrency.
     */
    public var totalIncomingValue: String? = nil
    
    /**
     * Total amount received by the address in USD.
     */
    public var totalIncomingValueUsd: String? = nil
    
    /**
     * Total amount sent by the address in cryptocurrency.
     */
    public var totalOutgoingValue: String? = nil
    
    /**
     * Total amount sent by the address in USD.
     */
    public var totalOutgoingValueUsd: String? = nil
    
    /**
     * UTC Timestamp for when this resource was created by you.
     */
    public var createdAt: String? = nil
    
    /**
     * UTC Timestamp for most recent lookup of this resource.
     */
    public var updatedAt: String? = nil
}
