//
//  Transaction.swift
//  Starling Round Up
//
//  Created by Andy Rennard on 27/07/2023.
//

import Foundation

public typealias TransactionID = UUID

/// A transaction in a bank account
public struct Transaction: Decodable {
    public let feedItemUid: TransactionID
    public let transactionTime: Date
    public let updatedAt: Date
    public let direction: Transaction.Direction
    public let status: Transaction.Status
    public let reference: String
    public let amount: CurrencyAmount
    // Other properties are not parsed at this time…
    
    public enum Direction: String, Decodable {
        case `in` = "IN"
        case out = "OUT"
    }
    
    public enum Status: String, Decodable {
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
