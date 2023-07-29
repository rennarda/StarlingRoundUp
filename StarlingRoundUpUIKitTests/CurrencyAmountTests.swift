//
//  CurrencyCodeTests.swift
//  StarlingRoundUpUIKitTests
//
//  Created by Andrew Rennard on 29/07/2023.
//

import XCTest
@testable import StarlingRoundUpUIKit

final class CurrencyAmountTests: XCTestCase {

    func test_addingCurrencyAmounts() {
        XCTAssertEqual(CurrencyAmount(currency: .GBP, minorUnits: 10) + CurrencyAmount(currency: .GBP, minorUnits: 15),
                       CurrencyAmount(currency: .GBP, minorUnits: 25)
        )
    }
}
