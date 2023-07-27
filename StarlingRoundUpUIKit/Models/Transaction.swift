//
//  Transaction.swift
//  Starling Round Up
//
//  Created by Andy Rennard on 27/07/2023.
//

import Foundation


/// A transaction in a bank account
struct Transaction: Decodable {
    let feedItemUid: UUID
    let transactionTime: Date
    let updatedAt: Date
    let direction: Transaction.Direction
    let status: Transaction.Status
    let reference: String
    let amount: CurrencyAmount
    // Other properties are not parsed at this time…
    
    enum Direction: String, Decodable {
        case `in` = "IN"
        case out = "OUT"
    }
    
    enum Status: String, Decodable {
        case upcoming = "UPCOMING"
        case pending = "PENDING"
        case reversed = "REVERSED"
        case settled = "SETTLED"
        case declined = "DECLINED"
        case refunded = "REFUNDED"
        case retrying = "RETRYING"
        case accountCheck = "ACCOUNT_CHECK"
    }
}
