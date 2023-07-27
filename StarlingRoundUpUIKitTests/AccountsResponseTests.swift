//
//  AccountsResponseTests.swift
//  Starling Round UpTests
//
//  Created by Andy Rennard on 27/07/2023.
//

import XCTest
@testable import Starling_Round_Up

final class AccountsResponseTests: XCTestCase {
    
    func test_decodingResponse() {
        let jsonData = """
        {
          "accounts": [
            {
              "accountUid": "e75f9bb0-3a61-4e58-92b4-d266b2e04041",
              "accountType": "PRIMARY",
              "defaultCategory": "e75f6fbb-29fb-49e0-acc0-6717c0f3eb48",
              "currency": "GBP",
              "createdAt": "2023-07-27T09:35:24.450Z",
              "name": "Personal"
            }
          ]
        }
        """.data(using: .utf8)!
        
        if let response: AccountsResponse = testDecoding(from: jsonData) {
            XCTAssertEqual(response.accounts.count, 1)
            XCTAssertEqual(response.accounts[0].accountType, .primary)
            XCTAssertEqual(response.accounts[0].currency, .GBP)
            XCTAssertEqual(response.accounts[0].name, "Personal")
            XCTAssertEqual(response.accounts[0].accountUid, UUID(uuidString: "e75f9bb0-3a61-4e58-92b4-d266b2e04041"))
            XCTAssertEqual(response.accounts[0].createdAt, DateFormatter.starlingFormatter.date(from: "2023-07-27T09:35:24.450Z"))
        }
    }
}
