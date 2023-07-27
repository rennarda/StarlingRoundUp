//
//  TransactionsResponse.swift
//  Starling Round Up
//
//  Created by Andy Rennard on 27/07/2023.
//

import Foundation

struct TransactionsResponse: Decodable {
    let feedItems: [Transaction]
}
