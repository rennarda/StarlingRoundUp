//
//  SavingsService.swift
//  StarlingRoundUpUIKit
//
//  Created by Andrew Rennard on 27/07/2023.
//

import Foundation

/// Methods to interact with the `savings goals` service endpoints
public protocol SavingsServiceProtocol {
    /// Create a savings goal
    /// - Parameters:
    ///   - named: the name to give the savings goal
    ///   - in: the account to create the goal in
    ///   - currency: the currency for the goal
    /// - Returns: a `SavingsGoal`
    /// - Throws: an `APIError` is something went wrong
    func createSavingsGoal(named: String, in: Account, currency: CurrencyCode) async throws -> SavingsGoal
    
    /// Add currency to a savings goal
    /// - Parameters:
    ///   - _: the amount of currency to add to the goal
    ///   - to: the savings goal to add the currency to
    ///   - in: the account that the savings goal belongs to
    /// - Throws: An `APIError` if something went wrong
    func add(_: CurrencyAmount, to: SavingsGoal, in: Account) async throws
    // Out of scope: fetch current savings goals
}

struct SavingsService: SavingsServiceProtocol {
    func createSavingsGoal(named goalName: String, in account: Account, currency: CurrencyCode) async throws  -> SavingsGoal
    {
        let url = StarlingAPIClient.baseURL
            .appending(path: "account")
            .appending(path: account.accountUid.uuidString.lowercased())
            .appending(path: "savings-goals")
        let requestBody = CreateSavingsGoalRequest(name: goalName, currency: currency, target: CurrencyAmount(currency: currency, minorUnits: .max))
        let response: CreateSavingsGoalResponse = try await StarlingAPIClient.put(url: url, with: requestBody)
        return SavingsGoal(name: goalName, id: response.savingsGoalUid)
    }
    
    func add(_ amount: CurrencyAmount, to savingsGoal: SavingsGoal, in account: Account) async throws {
        let url = StarlingAPIClient.baseURL
            .appending(path: "account")
            .appending(path: account.accountUid.uuidString.lowercased())
            .appending(path: "savings-goals")
            .appending(path: savingsGoal.id.uuidString.lowercased())
            .appending(path: "add-money")
            .appending(path: UUID().uuidString)
        let requestBody = AddMoneyToSavingsGoalRequest(amount: amount)
        let _: AddMoneyToSavingsGoalResponse = try await StarlingAPIClient.put(url: url, with: requestBody)
    }
    
    
}
