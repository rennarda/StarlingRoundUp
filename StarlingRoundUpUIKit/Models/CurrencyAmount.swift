//
//  CurrencyAmount.swift
//  Starling Round Up
//
//  Created by Andy Rennard on 27/07/2023.
//

import Foundation
struct CurrencyAmount: Decodable {
    let currency: CurrencyCode
    let minorUnits: Int64
}
