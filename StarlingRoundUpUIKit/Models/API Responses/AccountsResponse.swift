//
//  AccountsResponse.swift
//  Starling Round Up
//
//  Created by Andy Rennard on 27/07/2023.
//

import Foundation

/// The response from the `/v2/api/accounts` endpoint
struct AccountsResponse: Decodable {
    let accounts: [Account]
}


