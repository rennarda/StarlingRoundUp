//
//  CreateSavingsGoal.swift
//  Starling Round Up
//
//  Created by Andy Rennard on 27/07/2023.
//

import Foundation

public typealias TransferID = UUID

/// The request body to create a savings goal
struct CreateSavingsGoalRequest: Codable {
    let name: String
    let currency: CurrencyCode
    let target: CurrencyAmount
}

/// The response from creating a savings goal
struct CreateSavingsGoalResponse: Codable {
    let savingsGoalUid: SavingsGoalID
}

struct AddMoneyToSavingsGoalRequest: Codable, Equatable {
    let amount: CurrencyAmount
}

struct AddMoneyToSavingsGoalResponse: Codable {
    let success: Bool
    let transferUid: TransferID
}
