//
//  CurrencyAmount.swift
//  Starling Round Up
//
//  Created by Andy Rennard on 27/07/2023.
//

import Foundation

public struct CurrencyAmount: Codable {
    public let currency: CurrencyCode
    public let minorUnits: Int64
}

extension CurrencyAmount: Equatable {}

public extension CurrencyAmount {
    static func + (lhs: CurrencyAmount, rhs: CurrencyAmount) -> CurrencyAmount {
        assert(lhs.currency == rhs.currency)
        return CurrencyAmount(currency: lhs.currency, minorUnits: lhs.minorUnits + rhs.minorUnits)
    }
    
    /// Calculate the roundup amount for a `CurrencyAmount`
    ///
    /// *Assumptions*:
    /// * that transactions at zero units do not need rounding up
    /// * that all currencies have 100 minor units to their major units (eg. pence, cents, etc).
    /// - Parameter transactionAmount: the `CurrencyAmount` to round up
    /// - Returns: a `CurrencyAmount` to round the transaction up to the nearest whole unit
    func roundupAmount() -> CurrencyAmount? {
        guard minorUnits % 100 != 0 else { return nil }
        return CurrencyAmount(currency: currency, minorUnits: 100 - (minorUnits % 100))
    }
}

extension CurrencyAmount: CustomStringConvertible {
    public var description: String {
        (Decimal(minorUnits) / 100).formatted(.currency(code: currency.rawValue))
    }
}
