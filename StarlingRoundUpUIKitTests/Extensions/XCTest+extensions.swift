//
//  XCTest+extensions.swift
//  Starling Round UpTests
//
//  Created by Andy Rennard on 27/07/2023.
//

import Foundation
import XCTest

extension XCTest {
    func testDecoding<T: Decodable>(from data: Data) -> T? {
        do {
            return try T.decode(from: data)
        } catch let DecodingError.dataCorrupted(context) {
            XCTFail(context.debugDescription)
        } catch let DecodingError.keyNotFound(key, context) {
            XCTFail("Value '\(key)' not found: \(context.debugDescription), codingPath: \(context.codingPath)")
        } catch let DecodingError.valueNotFound(value, context) {
            XCTFail("Value '\(value)' not found: \(context.debugDescription), codingPath: \(context.codingPath)")
        } catch let DecodingError.typeMismatch(type, context)  {
            XCTFail("Value '\(type)' not found: \(context.debugDescription), codingPath: \(context.codingPath)")
        } catch {
            XCTFail(error.localizedDescription)
        }
        return nil
    }
}
