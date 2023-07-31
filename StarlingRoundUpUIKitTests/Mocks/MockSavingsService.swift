//
//  MockSavingsService.swift
//  StarlingRoundUpUIKit
//
//  Created by Andrew Rennard on 28/07/2023.
//

import Foundation
import StarlingRoundUpUIKit

class MockSavingsService: SavingsServiceProtocol {
    var apiClient: StarlingAPIClientProtocol = MockAPIClient()
    var error: Error?
    var roundupsAdded: [(CurrencyAmount, SavingsGoal, Account)] = []
    
    func createSavingsGoal(named: String, in: StarlingRoundUpUIKit.Account, currency: StarlingRoundUpUIKit.CurrencyCode) async throws -> StarlingRoundUpUIKit.SavingsGoal {
        if let error {
            throw error
        } else {
            return SavingsGoal.mock
        }
    }
    
    func add(_ amount: StarlingRoundUpUIKit.CurrencyAmount, to goal: StarlingRoundUpUIKit.SavingsGoal, in account: StarlingRoundUpUIKit.Account, transferID: UUID) async throws
    {
        if let error {
            throw error
        } else {
            roundupsAdded.append((amount, goal, account))
        }
    }
}

