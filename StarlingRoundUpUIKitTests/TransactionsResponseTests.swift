//
//  TransactionsResponseTests.swift
//  Starling Round UpTests
//
//  Created by Andy Rennard on 27/07/2023.
//

import XCTest
@testable import Starling_Round_Up

final class TransactionsResponseTests: XCTestCase {

    func test_decoding() {
        let jsonData = """
        {
        "feedItems": [{
            "feedItemUid": "e76010b9-009f-4bfe-8d8c-44639c134b5e",
            "categoryUid": "e75f6fbb-29fb-49e0-acc0-6717c0f3eb48",
            "amount": {
                "currency": "GBP",
                "minorUnits": 50000
            },
            "sourceAmount": {
                "currency": "GBP",
                "minorUnits": 50000
            },
            "direction": "IN",
            "updatedAt": "2023-07-27T09:36:11.738Z",
            "transactionTime": "2023-07-27T09:36:11.000Z",
            "settlementTime": "2023-07-27T09:36:11.000Z",
            "source": "FASTER_PAYMENTS_IN",
            "status": "SETTLED",
            "counterPartyType": "SENDER",
            "counterPartyName": "Faster payment",
            "counterPartySubEntityName": "",
            "counterPartySubEntityIdentifier": "600522",
            "counterPartySubEntitySubIdentifier": "20025645",
            "reference": "Ref: 3809787631",
            "country": "GB",
            "spendingCategory": "INCOME",
            "hasAttachment": false,
            "hasReceipt": false,
            "batchPaymentDetails": null
        },
        {
            "feedItemUid": "e760cab7-0f80-4387-a8ec-a993aa261d3f",
            "categoryUid": "e75f6fbb-29fb-49e0-acc0-6717c0f3eb48",
            "amount": {
                "currency": "GBP",
                "minorUnits": 200000
            },
            "sourceAmount": {
                "currency": "GBP",
                "minorUnits": 200000
            },
            "direction": "IN",
            "updatedAt": "2023-07-27T09:36:11.982Z",
            "transactionTime": "2023-07-27T09:36:11.000Z",
            "settlementTime": "2023-07-27T09:36:11.000Z",
            "source": "FASTER_PAYMENTS_IN",
            "status": "SETTLED",
            "counterPartyType": "SENDER",
            "counterPartyName": "Faster payment",
            "counterPartySubEntityName": "",
            "counterPartySubEntityIdentifier": "600522",
            "counterPartySubEntitySubIdentifier": "20025661",
            "reference": "Ref: 8508776944",
            "country": "GB",
            "spendingCategory": "INCOME",
            "hasAttachment": false,
            "hasReceipt": false,
            "batchPaymentDetails": null
        }
        ]
        }
        """.data(using: .utf8)!
        
        if let response: TransactionsResponse = testDecoding(from: jsonData) {
            XCTAssertEqual(response.feedItems.count, 2)
            let item = response.feedItems[0]
            XCTAssertEqual(item.feedItemUid, UUID(uuidString: "e76010b9-009f-4bfe-8d8c-44639c134b5e"))
            XCTAssertEqual(item.direction, .in)
            XCTAssertEqual(item.status, .settled)
            XCTAssertEqual(item.amount.currency, .GBP)
            XCTAssertEqual(item.amount.minorUnits, 50000)
            XCTAssertEqual(item.reference, "Ref: 3809787631")
            XCTAssertEqual(item.transactionTime, DateFormatter.starlingFormatter.date(from: "2023-07-27T09:36:11.000Z"))
        }

    }

}
