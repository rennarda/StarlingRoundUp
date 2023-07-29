//
//  SavingsService.swift
//  StarlingRoundUpUIKit
//
//  Created by Andrew Rennard on 27/07/2023.
//

import Foundation

public protocol SavingsServiceProtocol {
    func createSavingsGoal(named: String, in: Account, currency: CurrencyCode) async throws -> SavingsGoal
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
