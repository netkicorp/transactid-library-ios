//
//  Output.swift
//  transactId-library-ios
//
//  Created by Developer on 09.02.2021.
//

import Foundation

/**
 * Representation of Output message.
 */
class Output {
    
    /**
     * Number of satoshis (0.00000001 BTC) to be paid.
     */
    var amount: Int = 0
    
    /**
     * A "TxOut" script where payment should be sent.
     * This will normally be one of the standard Bitcoin transaction scripts (e.g. pubkey OP_CHECKSIG).
     */
    var script: String? = nil
    
    /**
     * Currency of the address.
     */
    var currency: AddressCurrency = .BITCOIN
    
    /**
     * Detailed information of this address.
     * This field is only to return data fetched from the address information provider.
     * This does not need to be filled when the object is being created.
     */
    var addressInformation: AddressInformation? = nil
}
