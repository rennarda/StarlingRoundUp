//
//  CreateSavingsGoal.swift
//  Starling Round Up
//
//  Created by Andy Rennard on 27/07/2023.
//

import Foundation

public typealias TransferID = UUID

/// The request body to create a savings goal
struct CreateSavingsGoalRequest: Encodable {
    let name: String
    let currency: CurrencyCode
    let target: CurrencyAmount
}

/// The response from creating a savings goal
struct CreateSavingsGoalResponse: Decodable {
    let savingsGoalUid: SavingsGoalID
}

struct AddMoneyToSavingsGoalRequest: Encodable {
    let amount: CurrencyAmount
}

struct AddMoneyToSavingsGoalResponse: Decodable {
    let success: Bool
    let transferUid: TransferID
}
