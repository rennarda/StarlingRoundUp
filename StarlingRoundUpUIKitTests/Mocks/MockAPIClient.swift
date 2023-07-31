//
//  MockAPIClient.swift
//  StarlingRoundUpUIKitTests
//
//  Created by Andy Rennard on 31/07/2023.
//

import Foundation
@testable import StarlingRoundUpUIKit

class MockAPIClient: StarlingAPIClientProtocol {
    var requestURL: URL?
    var requestData: Data?
    var responseData: Data?

    func get<T>(url: URL) async throws -> T where T : Decodable {
        requestURL = url
        return try respond()
    }
    
    func post<T, U>(url: URL, with body: U) async throws -> T where T : Decodable, U : Encodable {
        requestURL = url
        requestData = try? body.encode()
        return try respond()
    }
    
    func put<T, U>(url: URL, with body: U) async throws -> T where T : Decodable, U : Encodable {
        requestURL = url
        requestData = try? body.encode()
        return try respond()
    }
    
    private func respond<T: Decodable>() throws -> T {
        guard let responseData else {
            throw APIError.invalidResponse
        }
        return try T.decode(from: responseData)
    }
}
