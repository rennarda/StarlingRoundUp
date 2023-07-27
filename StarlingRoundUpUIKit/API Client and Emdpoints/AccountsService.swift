//
//  AccountsService.swift
//  StarlingRoundUpUIKit
//
//  Created by Andrew Rennard on 27/07/2023.
//

import Foundation

protocol AccountsServiceProtocol {
    func getAccounts() async throws -> [Account]
}

struct AccountsService: AccountsServiceProtocol {
    func getAccounts() async throws -> [Account] {
        let url = StarlingAPIClient.baseURL.appendingPathComponent("accounts")
        let response: AccountsResponse = try await StarlingAPIClient.get(url: url)
        return response.accounts
    }
    
}
