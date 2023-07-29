//
//  SavingsGoal.swift
//  Starling Round Up
//
//  Created by Andy Rennard on 27/07/2023.
//

import Foundation

public typealias SavingsGoalID = UUID

/// A Savings Goal
public struct SavingsGoal: Decodable {
    let name: String
    let id: SavingsGoalID
    
    public init(name: String, id: SavingsGoalID) {
        self.name = name
        self.id = id
    }    
}
