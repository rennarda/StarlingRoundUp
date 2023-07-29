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
    
    func test_roundupAmount() throws {
        XCTAssertEqual(CurrencyAmount(currency: .GBP, minorUnits: 1234).roundupAmount(),
                       CurrencyAmount(currency: .GBP, minorUnits: 66))

        XCTAssertEqual(CurrencyAmount(currency: .GBP, minorUnits: 9999).roundupAmount(),
                       CurrencyAmount(currency: .GBP, minorUnits: 1))
        
        XCTAssertNil(CurrencyAmount(currency: .GBP, minorUnits: 1000).roundupAmount())

        XCTAssertEqual(CurrencyAmount(currency: .GBP, minorUnits: 21).roundupAmount(),
                       CurrencyAmount(currency: .GBP, minorUnits: 79))
    }
    
    func test_description() {
        XCTAssertEqual(CurrencyAmount(currency: .GBP, minorUnits: 1234).description, "£12.34")
        XCTAssertEqual(CurrencyAmount(currency: .GBP, minorUnits: 23).description, "£0.23")
        XCTAssertEqual(CurrencyAmount(currency: .GBP, minorUnits: 123456).description, "£1,234.56")
    }
}
