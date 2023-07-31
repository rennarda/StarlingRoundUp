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
    case notImplemented
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

public protocol StarlingAPIClientProtocol {
    /// Perform a `GET` request
    /// - Parameters:
    ///   - url: the URL to request
    /// - Returns: The decoded response type
    func get<T: Decodable>(url: URL) async throws -> T
    
    /// Perform am HTTP POST request
    /// - Parameters:
    ///   - url: the URL to request
    ///   - body: an `Encodable` type to set as the request body
    /// - Returns: The decoded response type
    func post<T: Decodable, U: Encodable>(url: URL, with: U) async throws -> T
    
    /// Perform an HTTP PUT request
    /// - Parameters:
    ///   - url: the URL to request
    ///   - body: an encodable type to set as the request body
    /// - Returns: The decoded response type
    func put<T: Decodable, U: Encodable>(url: URL, with: U) async throws -> T
}

/// An API Client for the Starling API
class StarlingAPIClient: StarlingAPIClientProtocol {
    /// replace this with a working access token
    static let authToken = """
    eyJhbGciOiJQUzI1NiIsInppcCI6IkdaSVAifQ.H4sIAAAAAAAA_21Ty5KcMAz8lRTn1RYPYx633PID-QBhyzOuBZuyzWy2Uvn3GMwMw9Te6G6pJVnib6a9z_oMZw2SJvvuA7pRm8uA5uNd2Cl7y_wyxAhqasVKzqHKawmMlR0MtaihabtClJLVNccYTH_mrC94l7cty6vyLdMYEtF0DV8JFMIuJvyyoyT3W8vdu5WsA8VUCUxxAqwqBqLqyoLaUrWsi97BfpBJGUqqlrcNB4GMAeNFAUOLCnjD63zIh7YuecyIY_0Ugrw_6mAuOuADxSwcCsBy6KAUfGiqhuWIch1Y2JnWR0mdwnVrFQxO1DtC-eNFCF_zi6AlmaCVJnfmR-3DidmBlC422ZPU4QGSEgKK60SPyCVcrdM-bgi0kfqm5YJj0gYc0Yi9E4FOgrAmODsm35XZNWuUdhMGbQ1YBWoxcq8nFh_sdG-bJtR79oRGYqBe0kiBHnALmyhgRNiLCFfxjrfMGb-I7lICu0kCRxDoCS-7Z9KOTwgOjUex9vygYbQiTn94JwLs-gyv7J7lrNLjvVSqfaK2KEeC9BxOwJ-lT6eju8dbXIWHiz36OHH7qCdu83lm0nAqPvs3Fof4jdchJlNxJbmMJCGOfVyNpxDigMu8wxnvZxJ_93hF8Zisk0_lz-y97pn9Jh_sp3nwgdYGQPjbKzVLlajnnW6reF1y9u8_NOcoAaEEAAA.cq-c084t-0hP1JlIQA8-QdAQe4r_krtcz0UyCfWRySp2oJIJwL4BEg_w4BAWK5PoOpO5R1i-000qhIlp1HidNYkaoX1fV0INE96Qv_SSnCD0KfYwPU7gCrgBI-5nEB3hjQ-q86dwts2pqUhuhsbgzMVeg1hVvjdWdyWj-CMimBBUsoL_avqoX6g-UwpWJMQGV_Pqcifpyax6HTm-HTBFPxzbLyZnpJJq3gzHhK0rzCehtipXLNJ-I7kdhpj7bALoBzOVvKYOgXKtwcbCk3mGv6mBSSWQmQFmhYS1yIJMWnHF0xaVl9AN9P94WqIKBCzOojX5NPk46JE0oZogCFIjiDzYFZIQHEMjLTFfQgLh0LuHkUJVuyEbqeQN2CXHcCW7RYQ1kRpJpQCUYyRBvx7NVZs82rSY2z7PeVUGTHrw-XZK7doKXoUrC9QZyMQllwk9r5ebCi9CqDTdFoHM3ofTzbe0dlwGzkPm9l7qgaHD64-UFQYbFrCNAzF3_Q3xIFQe5toPGN3kWL-9NCQsL2TGr0AtOxY0Tkul041EEs7SxG-6plb9BjEhLhSgQQHkftwofnW1cn72LFq551aD7Aqis8mY6BZZQUo3nxZdFfFEVOIYe7rRLycVQuHu-jXDqmSESwMfFPYH5mWHNy74WrbN5Lh3RmPs_dPVuZJD_OiyrYY
    """
    
    static let baseURL = URL(string: "https://api-sandbox.starlingbank.com/api/v2")!
    static let shared = StarlingAPIClient()
    
    /// Perform a request with an encodable body type
    /// - Parameters:
    ///   - url: the URL to request
    ///   - method: the HTTP method to use
    ///   - body: an encodable type to set as the request body
    /// - Returns: The decoded response type
    private func request<T: Decodable, U: Encodable>(url: URL, method: HTTPMethod, with body: U? = nil) async throws -> T {
        var request = URLRequest(url: url)
        request.setStandardHeaders(withBearerToken: Self.authToken)
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
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
    private func request<T: Decodable>(url: URL, method: HTTPMethod) async throws -> T {
        var request = URLRequest(url: url)
        request.setStandardHeaders(withBearerToken: Self.authToken)
        request.httpMethod = method.rawValue
        return try await perform(request)
    }
    
    /// The main request handler function - all other functions call into this to actually perform the request
    /// - Parameters:
    ///   - request: the `URLRequest` to perform
    /// - Returns: The decoded response type
    private func perform<T: Decodable>(_ request: URLRequest) async throws -> T {
    
        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse,
                200...299 ~= httpResponse.statusCode
        else {
            //TODO: Parse an API error response
            throw APIError.invalidResponse
        }
        
        do {
            return try T.decode(from: data)
        } catch {
            throw APIError.decodingError(error)
        }
    }
    
    func get<T: Decodable>(url: URL) async throws -> T {
        try await request(url: url, method: .get)
    }
    
    func post<T: Decodable, U: Encodable>(url: URL, with body: U) async throws -> T {
        try await request(url: url, method: .get, with: body)
    }
    
    func put<T: Decodable, U: Encodable>(url: URL, with body: U) async throws -> T {
        try await request(url: url, method: .put, with: body)
    }
}
