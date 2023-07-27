//
//  APIClient.swift
//  Starling Round Up
//
//  Created by Andy Rennard on 27/07/2023.
//

import Foundation

public enum HTTPMethod: String {
    case `get` = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

enum APIError: Error {
    case invalidURL
    case invalidResponse
    case responseError(Error)
    case decodingError(Error)
    case encodingError(Error)
    case genericError(Error)
}

extension URLRequest {
    mutating func setStandardHeaders(withBearerToken token: String) {
        self.setValue("application/json", forHTTPHeaderField: "Accept")
        self.setValue("Starling Round Up", forHTTPHeaderField: "User-Agent")
        self.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    }
}

/// An API Client for the Starling API
class StarlingAPIClient {
    static let authToken = "eyJhbGciOiJQUzI1NiIsInppcCI6IkdaSVAifQ.H4sIAAAAAAAA_21Ty5KjMAz8lS3OoykehgRue9sf2A8Qlpy4BmzKNpmd2tp_X4NJCKm50d1SS7LE30x7n3UZThqIR_vuA7pBm0uP5uNd2jF7y_zcxwg"
    
    typealias CompletionHandler<T: Codable> = (Result<T, APIError>) -> Void
    
    /// Perform a request with an encodable body type
    /// - Parameters:
    ///   - url: the URL to request
    ///   - method: the HTTP method to use
    ///   - body: an encodable type to set as the request body
    /// - Returns: The decoded response type
    private static func request<T: Decodable, U: Encodable>(url: URL, method: HTTPMethod, with body: U? = nil) async throws -> T {
        var request = URLRequest(url: url)
        request.setStandardHeaders(withBearerToken: Self.authToken)
        do {
            request.httpBody = try body.encode()
        } catch let error as EncodingError {
            throw APIError.encodingError(error)
        } catch {
            throw APIError.genericError(error)
        }
        request.httpMethod = method.rawValue
        return try await perform(request)
    }
    
    /// Perform a request that does not contain a http body
    /// - Parameters:
    ///   - url: the URL to request
    ///   - method: the HTTP method to use
    /// - Returns: The decoded response type
    private static func request<T: Decodable>(url: URL, method: HTTPMethod) async throws -> T {
        var request = URLRequest(url: url)
        request.setStandardHeaders(withBearerToken: Self.authToken)
        request.httpMethod = method.rawValue
        return try await perform(request)
    }
    
    /// The main request handler function - all other functions call into this to actually perform the request
    /// - Parameters:
    ///   - request: the `URLRequest` to perform
    /// - Returns: The decoded response type
    private static func perform<T: Decodable>(_ request: URLRequest) async throws -> T {
    
        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse,
                200...299 ~= httpResponse.statusCode
        else {
            throw APIError.invalidResponse
        }
        
        do {
            return try T.decode(from: data)
        } catch {
            throw APIError.decodingError(error)
        }
    }
    
    /// Perform a `GET` request
    /// - Parameters:
    ///   - url: the URL to request
    /// - Returns: The decoded response type
    static func get<T: Decodable>(url: URL) async throws -> T {
        try await request(url: url, method: .get)
    }
    
    /// Perform am HTTP POST request
    /// - Parameters:
    ///   - url: the URL to request
    ///   - body: an `Encodable` type to set as the request body
    /// - Returns: The decoded response type
    static func post<T: Decodable, U: Encodable>(url: URL, with body: U) async throws -> T {
        try await request(url: url, method: .get, with: body)
    }
    
    /// Perform an HTTP PUT request
    /// - Parameters:
    ///   - url: the URL to request
    ///   - body: an encodable type to set as the request body
    /// - Returns: The decoded response type
    static func put<T: Decodable, U: Encodable>(url: URL, with body: U) async throws -> T {
        try await request(url: url, method: .put, with: body)
    }
}
