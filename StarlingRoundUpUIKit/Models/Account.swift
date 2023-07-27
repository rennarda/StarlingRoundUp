//
//  Account.swift
//  Starling Round Up
//
//  Created by Andy Rennard on 27/07/2023.
//

import Foundation

/// A bank account
struct Account: Decodable {
    let accountUid: UUID
    let accountType: AccountType
    let defaultCategory: UUID
    let currency: CurrencyCode
    let name: String
    let createdAt: Date
    
    /// An enum for the type of bank account
    enum AccountType: String, Codable {
        case primary = "PRIMARY"
        case additional = "ADDITIONAL"
        case load = "LOAN"
        case deposit = "FIXED_TERM_DEPOSIT"
    }
    
}
