//
//  MockAccountsService.swift
//  StarlingRoundUpUIKit
//
//  Created by Andrew Rennard on 28/07/2023.
//

import Foundation
import StarlingRoundUpUIKit

struct MockTransactionsService: TransactionsServiceProtocol {
    var error: Error?
    
    func getTransactions(for: StarlingRoundUpUIKit.Account, in: Range<Date>) async throws -> [StarlingRoundUpUIKit.Transaction] {

        if let error {
            throw error
        } else {
            return Transaction.mock
        }
    }
}

