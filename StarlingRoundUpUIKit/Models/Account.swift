//
//  Account.swift
//  Starling Round Up
//
//  Created by Andy Rennard on 27/07/2023.
//

import Foundation

public typealias AccountID = UUID
public typealias AccountCategoryID = UUID

/// A bank account
public struct Account: Decodable {
    public let accountUid: AccountID
    public let accountType: AccountType
    public let defaultCategory: AccountCategoryID
    public let currency: CurrencyCode
    public let name: String
    public let createdAt: Date

    public init(accountUid: AccountID, accountType: Account.AccountType, defaultCategory: AccountCategoryID, currency: CurrencyCode, name: String, createdAt: Date) {
        self.accountUid = accountUid
        self.accountType = accountType
        self.defaultCategory = defaultCategory
        self.currency = currency
        self.name = name
        self.createdAt = createdAt
    }
    
    /// An enum for the type of bank account
    public enum AccountType: String, Codable {
        case primary = "PRIMARY"
        case additional = "ADDITIONAL"
        case load = "LOAN"
        case deposit = "FIXED_TERM_DEPOSIT"
    }
    
}
