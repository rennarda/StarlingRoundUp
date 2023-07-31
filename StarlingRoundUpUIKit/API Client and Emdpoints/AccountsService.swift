//
//  AccountsService.swift
//  StarlingRoundUpUIKit
//
//  Created by Andrew Rennard on 27/07/2023.
//

import Foundation

public protocol ServiceProtocol {
    var apiClient: StarlingAPIClientProtocol { get }
}

/// Methods to interact with the `accounts` service endpoints
public protocol AccountsServiceProtocol: ServiceProtocol {
    /// Get the accounts for this user
    /// - Returns: an array of `Account` for this user
    /// - Throws: an `APIError` if something went wrong
    func getAccounts() async throws -> [Account]
}

struct AccountsService: AccountsServiceProtocol {
    var apiClient: StarlingAPIClientProtocol = StarlingAPIClient.shared
    
    func getAccounts() async throws -> [Account] {
        let url = StarlingAPIClient.baseURL.appendingPathComponent("accounts")
        let response: AccountsResponse = try await apiClient.get(url: url)
        return response.accounts
    }
    
}
