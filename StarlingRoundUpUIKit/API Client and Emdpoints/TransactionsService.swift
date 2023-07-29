//
//  TransactionsServiceProtocol.swift
//  StarlingRoundUpUIKit
//
//  Created by Andrew Rennard on 28/07/2023.
//

import Foundation

public protocol TransactionsServiceProtocol {
    /// Get the transactions for an account in the specified date range
    /// - Parameters:
    ///   - for: the account to fetch transactions for
    ///   - in: the date range to fetch transactions in
    /// - Returns: an array of `Transaction`
    func getTransactions(for: Account, in: Range<Date>) async throws -> [Transaction]
}

struct TransactionsService: TransactionsServiceProtocol {
    func getTransactions(for account: Account, in dateRange: Range<Date>) async throws -> [Transaction] {
        let queryItems = [
            URLQueryItem(name: "minTransactionTimestamp",
                         value: DateFormatter.starlingFormatter.string(from: dateRange.lowerBound)),
            URLQueryItem(name: "maxTransactionTimestamp",
                         value: DateFormatter.starlingFormatter.string(from: dateRange.lowerBound))
        ]

        let url = StarlingAPIClient.baseURL
            .appending(path: "feed/account")
            .appending(path: account.accountUid.uuidString)
            .appending(path: "settled-transactions-between")
            .appending(queryItems: queryItems)
            
        let response: TransactionsResponse = try await StarlingAPIClient.get(url: url)
        return response.feedItems
    }
}
