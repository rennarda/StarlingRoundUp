//
//  Account+Extensions.swift
//  StarlingRoundUpUIKitTests
//
//  Created by Andrew Rennard on 28/07/2023.
//

import Foundation
import StarlingRoundUpUIKit

extension Transaction {
    static var mock: [Transaction] {
        try! [Transaction].decode(from: Self.mockJSON)
    }
}

fileprivate extension Transaction {
    static var mockJSON: Data {
    """
    [
        {
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
        },
        {
          "feedItemUid": "e760df8a-f70a-480b-9429-fd47f3e7c213",
          "categoryUid": "e75f6fbb-29fb-49e0-acc0-6717c0f3eb48",
          "amount": {
            "currency": "GBP",
            "minorUnits": 3298
          },
          "sourceAmount": {
            "currency": "GBP",
            "minorUnits": 3298
          },
          "direction": "IN",
          "updatedAt": "2023-07-27T09:36:12.161Z",
          "transactionTime": "2023-07-27T09:36:12.000Z",
          "settlementTime": "2023-07-27T09:36:12.000Z",
          "source": "FASTER_PAYMENTS_IN",
          "status": "SETTLED",
          "counterPartyType": "SENDER",
          "counterPartyName": "Faster payment",
          "counterPartySubEntityName": "",
          "counterPartySubEntityIdentifier": "600522",
          "counterPartySubEntitySubIdentifier": "20025688",
          "reference": "Ref: 0870640036",
          "country": "GB",
          "spendingCategory": "INCOME",
          "hasAttachment": false,
          "hasReceipt": false,
          "batchPaymentDetails": null
        },
        {
          "feedItemUid": "e7607b16-b892-41de-b314-efea2548b152",
          "categoryUid": "e75f6fbb-29fb-49e0-acc0-6717c0f3eb48",
          "amount": {
            "currency": "GBP",
            "minorUnits": 1913
          },
          "sourceAmount": {
            "currency": "GBP",
            "minorUnits": 1913
          },
          "direction": "IN",
          "updatedAt": "2023-07-27T09:36:12.364Z",
          "transactionTime": "2023-07-27T09:36:12.000Z",
          "settlementTime": "2023-07-27T09:36:12.000Z",
          "source": "FASTER_PAYMENTS_IN",
          "status": "SETTLED",
          "counterPartyType": "SENDER",
          "counterPartyName": "Faster payment",
          "counterPartySubEntityName": "",
          "counterPartySubEntityIdentifier": "600522",
          "counterPartySubEntitySubIdentifier": "20025726",
          "reference": "Ref: 0642319273",
          "country": "GB",
          "spendingCategory": "INCOME",
          "hasAttachment": false,
          "hasReceipt": false,
          "batchPaymentDetails": null
        },
        {
          "feedItemUid": "e760e689-fe17-4004-b0ca-690ca20b3a98",
          "categoryUid": "e75f6fbb-29fb-49e0-acc0-6717c0f3eb48",
          "amount": {
            "currency": "GBP",
            "minorUnits": 970
          },
          "sourceAmount": {
            "currency": "GBP",
            "minorUnits": 970
          },
          "direction": "IN",
          "updatedAt": "2023-07-27T09:36:12.182Z",
          "transactionTime": "2023-07-27T09:36:12.000Z",
          "settlementTime": "2023-07-27T09:36:12.000Z",
          "source": "FASTER_PAYMENTS_IN",
          "status": "SETTLED",
          "counterPartyType": "SENDER",
          "counterPartyName": "Faster payment",
          "counterPartySubEntityName": "",
          "counterPartySubEntityIdentifier": "600522",
          "counterPartySubEntitySubIdentifier": "20025696",
          "reference": "Ref: 7398251459",
          "country": "GB",
          "spendingCategory": "INCOME",
          "hasAttachment": false,
          "hasReceipt": false,
          "batchPaymentDetails": null
        },
        {
          "feedItemUid": "e760b9e5-d96a-47a2-9ec9-383955cbded2",
          "categoryUid": "e75f6fbb-29fb-49e0-acc0-6717c0f3eb48",
          "amount": {
            "currency": "GBP",
            "minorUnits": 3460
          },
          "sourceAmount": {
            "currency": "GBP",
            "minorUnits": 3460
          },
          "direction": "IN",
          "updatedAt": "2023-07-27T09:36:12.323Z",
          "transactionTime": "2023-07-27T09:36:12.000Z",
          "settlementTime": "2023-07-27T09:36:12.000Z",
          "source": "FASTER_PAYMENTS_IN",
          "status": "SETTLED",
          "counterPartyType": "SENDER",
          "counterPartyName": "Faster payment",
          "counterPartySubEntityName": "",
          "counterPartySubEntityIdentifier": "600522",
          "counterPartySubEntitySubIdentifier": "20025734",
          "reference": "Ref: 8147573813",
          "country": "GB",
          "spendingCategory": "INCOME",
          "hasAttachment": false,
          "hasReceipt": false,
          "batchPaymentDetails": null
        },
        {
          "feedItemUid": "e760489d-a57a-421a-a1f7-e2a09aec910e",
          "categoryUid": "e75f6fbb-29fb-49e0-acc0-6717c0f3eb48",
          "amount": {
            "currency": "GBP",
            "minorUnits": 1950
          },
          "sourceAmount": {
            "currency": "GBP",
            "minorUnits": 1950
          },
          "direction": "IN",
          "updatedAt": "2023-07-27T09:36:12.467Z",
          "transactionTime": "2023-07-27T09:36:12.000Z",
          "settlementTime": "2023-07-27T09:36:12.000Z",
          "source": "FASTER_PAYMENTS_IN",
          "status": "SETTLED",
          "counterPartyType": "SENDER",
          "counterPartyName": "Faster payment",
          "counterPartySubEntityName": "",
          "counterPartySubEntityIdentifier": "600522",
          "counterPartySubEntitySubIdentifier": "20025742",
          "reference": "Ref: 6158350306",
          "country": "GB",
          "spendingCategory": "INCOME",
          "hasAttachment": false,
          "hasReceipt": false,
          "batchPaymentDetails": null
        },
        {
          "feedItemUid": "e7609d37-e131-4151-94d7-c5c5130e9c6c",
          "categoryUid": "e75f6fbb-29fb-49e0-acc0-6717c0f3eb48",
          "amount": {
            "currency": "GBP",
            "minorUnits": 659
          },
          "sourceAmount": {
            "currency": "GBP",
            "minorUnits": 659
          },
          "direction": "IN",
          "updatedAt": "2023-07-27T09:36:12.543Z",
          "transactionTime": "2023-07-27T09:36:12.000Z",
          "settlementTime": "2023-07-27T09:36:12.000Z",
          "source": "FASTER_PAYMENTS_IN",
          "status": "SETTLED",
          "counterPartyType": "SENDER",
          "counterPartyName": "Faster payment",
          "counterPartySubEntityName": "",
          "counterPartySubEntityIdentifier": "600522",
          "counterPartySubEntitySubIdentifier": "20025769",
          "reference": "Ref: 9461196693",
          "country": "GB",
          "spendingCategory": "INCOME",
          "hasAttachment": false,
          "hasReceipt": false,
          "batchPaymentDetails": null
        },
        {
          "feedItemUid": "e760da5d-1e00-49d8-ab98-ca3dfd258bce",
          "categoryUid": "e75f6fbb-29fb-49e0-acc0-6717c0f3eb48",
          "amount": {
            "currency": "GBP",
            "minorUnits": 2971
          },
          "sourceAmount": {
            "currency": "GBP",
            "minorUnits": 2971
          },
          "direction": "OUT",
          "updatedAt": "2023-07-27T09:36:15.741Z",
          "transactionTime": "2023-07-27T09:36:12.183Z",
          "settlementTime": "2023-07-27T09:36:12.981Z",
          "source": "FASTER_PAYMENTS_OUT",
          "status": "SETTLED",
          "transactingApplicationUserUid": "e75f4266-305d-4429-b5c5-7891c2d4556a",
          "counterPartyType": "PAYEE",
          "counterPartyUid": "e7606c23-91bc-4cc5-b1c3-9bff76b36394",
          "counterPartyName": "Mickey Mouse",
          "counterPartySubEntityUid": "e7605d05-6a39-4aec-8414-6a2435eb7b7d",
          "counterPartySubEntityName": "UK account",
          "counterPartySubEntityIdentifier": "204514",
          "counterPartySubEntitySubIdentifier": "00000825",
          "reference": "External Payment",
          "country": "GB",
          "spendingCategory": "PAYMENTS",
          "hasAttachment": false,
          "hasReceipt": false,
          "batchPaymentDetails": null
        },
        {
          "feedItemUid": "e76045d3-6b3b-472c-aff1-b5c64cc0bed5",
          "categoryUid": "e75f6fbb-29fb-49e0-acc0-6717c0f3eb48",
          "amount": {
            "currency": "GBP",
            "minorUnits": 2079
          },
          "sourceAmount": {
            "currency": "GBP",
            "minorUnits": 2079
          },
          "direction": "OUT",
          "updatedAt": "2023-07-27T09:36:15.762Z",
          "transactionTime": "2023-07-27T09:36:12.142Z",
          "settlementTime": "2023-07-27T09:36:13.045Z",
          "source": "FASTER_PAYMENTS_OUT",
          "status": "SETTLED",
          "transactingApplicationUserUid": "e75f4266-305d-4429-b5c5-7891c2d4556a",
          "counterPartyType": "PAYEE",
          "counterPartyUid": "e760ce6f-60f1-4062-ba07-b3ca117e85ff",
          "counterPartyName": "Mickey Mouse",
          "counterPartySubEntityUid": "e760cf33-da5d-4394-88d9-6359017f9792",
          "counterPartySubEntityName": "UK account",
          "counterPartySubEntityIdentifier": "204514",
          "counterPartySubEntitySubIdentifier": "00000825",
          "reference": "External Payment",
          "country": "GB",
          "spendingCategory": "PAYMENTS",
          "hasAttachment": false,
          "hasReceipt": false,
          "batchPaymentDetails": null
        },
        {
          "feedItemUid": "e7604eeb-6dd2-4e8e-a8d9-83fffebc2962",
          "categoryUid": "e75f6fbb-29fb-49e0-acc0-6717c0f3eb48",
          "amount": {
            "currency": "GBP",
            "minorUnits": 1266
          },
          "sourceAmount": {
            "currency": "GBP",
            "minorUnits": 1266
          },
          "direction": "OUT",
          "updatedAt": "2023-07-27T09:36:13.165Z",
          "transactionTime": "2023-07-27T09:36:12.351Z",
          "settlementTime": "2023-07-27T09:36:13.097Z",
          "source": "FASTER_PAYMENTS_OUT",
          "status": "SETTLED",
          "transactingApplicationUserUid": "e75f4266-305d-4429-b5c5-7891c2d4556a",
          "counterPartyType": "PAYEE",
          "counterPartyUid": "e7602459-fb61-419b-b113-f7943acfea41",
          "counterPartyName": "Mickey Mouse",
          "counterPartySubEntityUid": "e760ab90-d27e-42c9-992e-0cd8cbc7410b",
          "counterPartySubEntityName": "UK account",
          "counterPartySubEntityIdentifier": "204514",
          "counterPartySubEntitySubIdentifier": "00000825",
          "reference": "External Payment",
          "country": "GB",
          "spendingCategory": "PAYMENTS",
          "hasAttachment": false,
          "hasReceipt": false,
          "batchPaymentDetails": null
        },
        {
          "feedItemUid": "e7601ac6-255d-4f52-8f3c-90757701c449",
          "categoryUid": "e75f6fbb-29fb-49e0-acc0-6717c0f3eb48",
          "amount": {
            "currency": "GBP",
            "minorUnits": 1712
          },
          "sourceAmount": {
            "currency": "GBP",
            "minorUnits": 1712
          },
          "direction": "OUT",
          "updatedAt": "2023-07-27T09:36:13.229Z",
          "transactionTime": "2023-07-27T09:36:12.429Z",
          "settlementTime": "2023-07-27T09:36:13.136Z",
          "source": "FASTER_PAYMENTS_OUT",
          "status": "SETTLED",
          "transactingApplicationUserUid": "e75f4266-305d-4429-b5c5-7891c2d4556a",
          "counterPartyType": "PAYEE",
          "counterPartyUid": "e760b728-bc01-4c4b-816e-006b9612ee22",
          "counterPartyName": "Mickey Mouse",
          "counterPartySubEntityUid": "e7606e47-7e4e-40d1-b2d4-1267a171c5d8",
          "counterPartySubEntityName": "UK account",
          "counterPartySubEntityIdentifier": "204514",
          "counterPartySubEntitySubIdentifier": "00000825",
          "reference": "External Payment",
          "country": "GB",
          "spendingCategory": "PAYMENTS",
          "hasAttachment": false,
          "hasReceipt": false,
          "batchPaymentDetails": null
        },
        {
          "feedItemUid": "e7608fd0-ab5c-4444-a928-0c5fb05e37d4",
          "categoryUid": "e75f6fbb-29fb-49e0-acc0-6717c0f3eb48",
          "amount": {
            "currency": "GBP",
            "minorUnits": 1927
          },
          "sourceAmount": {
            "currency": "GBP",
            "minorUnits": 1927
          },
          "direction": "OUT",
          "updatedAt": "2023-07-27T09:36:13.260Z",
          "transactionTime": "2023-07-27T09:36:12.309Z",
          "settlementTime": "2023-07-27T09:36:13.179Z",
          "source": "FASTER_PAYMENTS_OUT",
          "status": "SETTLED",
          "transactingApplicationUserUid": "e75f4266-305d-4429-b5c5-7891c2d4556a",
          "counterPartyType": "PAYEE",
          "counterPartyUid": "e760fa54-45a6-474d-91e7-9f772f240f48",
          "counterPartyName": "Mickey Mouse",
          "counterPartySubEntityUid": "e7608626-3708-4f3a-b948-359d00f65687",
          "counterPartySubEntityName": "UK account",
          "counterPartySubEntityIdentifier": "204514",
          "counterPartySubEntitySubIdentifier": "00000825",
          "reference": "External Payment",
          "country": "GB",
          "spendingCategory": "PAYMENTS",
          "hasAttachment": false,
          "hasReceipt": false,
          "batchPaymentDetails": null
        },
        {
          "feedItemUid": "e7604aa9-4bca-48a3-b066-a4bf6541554c",
          "categoryUid": "e75f6fbb-29fb-49e0-acc0-6717c0f3eb48",
          "amount": {
            "currency": "GBP",
            "minorUnits": 3908
          },
          "sourceAmount": {
            "currency": "GBP",
            "minorUnits": 3908
          },
          "direction": "OUT",
          "updatedAt": "2023-07-27T09:36:13.288Z",
          "transactionTime": "2023-07-27T09:36:12.511Z",
          "settlementTime": "2023-07-27T09:36:13.221Z",
          "source": "FASTER_PAYMENTS_OUT",
          "status": "SETTLED",
          "transactingApplicationUserUid": "e75f4266-305d-4429-b5c5-7891c2d4556a",
          "counterPartyType": "PAYEE",
          "counterPartyUid": "e760d248-97e4-478b-9fde-ba9500fd4d6a",
          "counterPartyName": "Mickey Mouse",
          "counterPartySubEntityUid": "e760a31c-7cd9-4173-a296-3b7d079d5148",
          "counterPartySubEntityName": "UK account",
          "counterPartySubEntityIdentifier": "204514",
          "counterPartySubEntitySubIdentifier": "00000825",
          "reference": "External Payment",
          "country": "GB",
          "spendingCategory": "PAYMENTS",
          "hasAttachment": false,
          "hasReceipt": false,
          "batchPaymentDetails": null
        }
      ]
    """.data(using: .utf8)!
    }
}
