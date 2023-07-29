//
//  CurrencyAmount.swift
//  Starling Round Up
//
//  Created by Andy Rennard on 27/07/2023.
//

import Foundation

public struct CurrencyAmount: Decodable {
    public let currency: CurrencyCode
    public let minorUnits: Int64
}

extension CurrencyAmount: Equatable {}

public extension CurrencyAmount {
    static func + (lhs: CurrencyAmount, rhs: CurrencyAmount) -> CurrencyAmount {
        assert(lhs.currency == rhs.currency)
        return CurrencyAmount(currency: lhs.currency, minorUnits: lhs.minorUnits + rhs.minorUnits)
    }
}
