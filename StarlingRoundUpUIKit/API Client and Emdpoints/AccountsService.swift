//
//  AccountsService.swift
//  StarlingRoundUpUIKit
//
//  Created by Andrew Rennard on 27/07/2023.
//

import Foundation

public protocol AccountsServiceProtocol {
    /// Get the accounts for this user
    /// - Returns: an array of `Account` for this user
    func getAccounts() async throws -> [Account]
}

struct AccountsService: AccountsServiceProtocol {
    func getAccounts() async throws -> [Account] {
        let url = StarlingAPIClient.baseURL.appendingPathComponent("accounts")
        let response: AccountsResponse = try await StarlingAPIClient.get(url: url)
        return response.accounts
    }
    
}
