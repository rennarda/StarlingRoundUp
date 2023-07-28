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
