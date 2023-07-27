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
    static let authToken = """
    eyJhbGciOiJQUzI1NiIsInppcCI6IkdaSVAifQ.H4sIAAAAAAAA_21Ty5KjMAz8lS3OoykehgRue9sf2A8Qlpy4BmzKNpmd2tp_X4NJCKm50d1SS7LE30x7n3UZThqIR_vuA7pBm0uP5uNd2jF7y_zcxwg-1UqUTQNVXhMIUbbQ17KG07ktZEmirhuMwfxnyrqiafO6atqyfss0hkSIOq8XAqW0swm_7EDsfmvavM8kWlBClSBUw4BVJUBWbVnwuVRn0UbvYD_Y7BlFrRSIGgWIpiXAngSc8FyoInaXtzJmxLF-Ssne71mYyxaanmMW9gVg2bdQyqY_VSeRI9IysLQTL4-SOoXr2ioYHLlzjPTjRQhf04ugiU3QSrM78oP24cBsgMjFJjsmHR4gKSGgvI78iJzD1Trt44ZAG9I3TTMOSetxQCO3TiQ6AmlNcHZIvguzadYo7UYM2hqwCtRsaKsnZx_seG-bR9Rb9oiGMHBHPHDgB1zDRg4YEXYywkW84zVzwi_mu5TAZpLAHgR6xMvmmbT9E4JD41EuPT9oGKyM0-_eiQC7PMMru2U5q_RwL5VqH6g1yrFkPYUD8Efp0-no7vEWV-HhYvc-Dtw26oFbfZ6ZNJyKz_6NxS5-47WLyVRemeaBCeLY-9V4DiEOOE8bnPB-JvF3j1cUj8k6eip_ZO91j-w3-WA_zYMPvDQA0t9eqYlUop53uq7idcnZv__ZEr-OoQQAAA.HvOY6OA0l8OGV7WXPRXVAdWXmJjij_Ya3Jg1iK6XbVisxrs-lQJM3YThyvoJf93LcE7f20SnIbRgFATO-3ATQc9CAFI9I5s5Dp_6ZV2kMX1BnBpp8JG7n7gbz0gXoJgwkQik3N5uRsvbKkYezfs1OqY4KGL2KIwufohS61zjskOdZV8CSuYIKSKXl1Zl0FCG-p8fA6S60HTJ2386ocDAZeBfQzrKvVkeMNxa7S6CXVtBjCa8kAQkQLf-4DpCETY9hk6QeUl5oFW2u00t94Krpq6g69TJwDVdlhyppFrk0sH3W7m7NncVfvuyDE-gDdZIn_oT-Sxzil0x4pJVbtzJuxsDZzSPOxJBKvuIwIVTRB8_wM3yPMSm07_4mzSBDoCJnSFVcpc4Vd8CRaJxnngawaGIIxfNyZ3uqXSdoVGt69TW8Mi8kICgN5iEs_sh0E6vZGBbwi2EYoztKEewh9Xo35_MvLOZVgx4YF1QqrSDx88QQOniS8UPkIgFbpYzp4rq8bGFHIDAjiMw2aElTCpKf3Jmu0bdHL3yaEVLA-u97Wndavm2Tsef9UuMJB9Ll3cQqEWrq6-dWgQDL6Kez8i1ijnXRDOS7kma-i7AaihE5sWluv-a95a-dneMVUS4Eody-ZhMD9UNK4OzFOjuv4LqDPF-EVgdk81lg_ImdaJicoU
    """
    
    static let baseURL = URL(string: "https://api-sandbox.starlingbank.com/api/v2")!
    
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
