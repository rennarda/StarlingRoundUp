//
//  TransactionsServiceProtocol.swift
//  StarlingRoundUpUIKit
//
//  Created by Andrew Rennard on 28/07/2023.
//

import Foundation

public protocol TransactionsServiceProtocol {
    func getTransactions(for: Account, categoryID: AccountCategoryID, in: Range<Date>) async throws -> [Transaction]
}

struct TransactionsService: TransactionsServiceProtocol {
    func getTransactions(for: Account, categoryID: AccountCategoryID, in: Range<Date>) async throws -> [Transaction] {
        throw APIError.notImplemented
    }
}
