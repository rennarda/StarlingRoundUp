//
//  MockAccountsService.swift
//  StarlingRoundUpUIKit
//
//  Created by Andrew Rennard on 28/07/2023.
//

import Foundation
import StarlingRoundUpUIKit

struct MockAccountsService: AccountsServiceProtocol {
    var error: Error?
    
    func getAccounts() async throws -> [Account] {
        if let error {
            throw error
        } else {
            return [Account.mock]
        }
    }
}

