//
//  Date+extensions.swift
//  Starling Round Up
//
//  Created by Andy Rennard on 27/07/2023.
//

import Foundation

extension Date {
    // The standard date format used by Starling API responses
    public static let starlingFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
}

extension DateFormatter {
    /// A standardised date formatter for parsing for formatting dates for the Starling API
    public static var starlingFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = Date.starlingFormat
        return formatter
    }
}
