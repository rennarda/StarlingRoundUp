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

/// An API Client for the Starling API
class StarlingAPIClient {
    static let authToken = """
    eyJhbGciOiJQUzI1NiIsInppcCI6IkdaSVAifQ.H4sIAAAAAAAA_21TQZKjMAz8yhbn0RQBAzG3ve0H9gHClhPXgE3ZJrNTW_v3NdgJITU3ultqSZb4W2jvi77AWYOkyb77gG7U5jKg-XgXdireCr8MMYK6RrGqbaEuGwmMVRyGRjTQnflJVJI1TYsxmP7MRX9qedk2bd2Vb4XGkIim5XwlUAi7mPDLjpLcby2z91kyDoqpCphqCbCuGYiaVyc6V-rMePQO9oNMzlBVi8jOgBWnmCEFIG9LqLATxGUsVLGYEcf6KQR5v9fBUnBoB2LAcDjF_IFDJdqhqztWIsp1YGFnWh8ldQrXrVUwOFHvCOWPFyF8zS-ClmSCVprckR-1DwcmAyldbLInqcMDJCUEFNeJHpFLuFqnfdwQaCP1TcsFx6QNOKIRuROBToKwJjg7Jt-VyZo1SrsJg7YGrAK1GJnricUHO93bpgl1zp7QSAzUSxop0ANuYRMFjAh7EeEq3vGWOeMX0V1KIJsksAeBnvCSPZO2f0JwaDyKtecHDaMVcfrdOxFg12d4ZXOWs0qP91Kp9oHaohwJ0nM4AH-UPp2O7h5vcRUeLnbv48DlUQ_c5vPMpOFUfPZvLHbxG69dTKbiSnIZSUIce78aTyHEAZc5wxnvZxJ_93hF8Zisk0_lj-y97pH9Jh_sp3nwgdYGQPjbKzVLlajnnW6reF1y8e8_uAWUfaEEAAA.xYiMRvevAPVIAEwv25syxLMv1INYgRSe6YOaehiNyLBbB5Ah_sgVDk4et76oUuk4pdr5fBmmzFV3S6yWNzpMUfwTC9hN8PkuvIUgCLeDiRLIDyFwvkYOwnyXMrOlf-5iePNJjrgKZWN2mtDYy3i_s1Ngl2zQC5ypw47In1xGrXZb2dU56v2FZKslFWltM0HacTphXm1Jml2AKKTnuOgZNwoOVhvsSVvnTDErOrzlMnplnF4CqVZpP99IcezZFM3Tnb8shtP2uPmx0UBLMPhbJNAEkBOxmx5TYoL09Y-IRt5rVK6-Mv9zUIdrU6mhboF2FoQG2aTOiWU3deu1W6L_eENosTK6CitRSMT_MXmFqxmqpr3nB-CtCe5aB7VSSi1Wm5uP0msQ6lZhtAsb_pJXkdSFTAOTbqAEo4aWiX2_eUoswIYs5oAgkOzqsrzOxX_3Hvypfh1xZOLNQBacsmyHJLgvmWRM25gkEURyug8ROMjv1QSJv7SfUzagbsF1XeFfn-gnX7tRcpUWBtHwwaPfffN-XqNeMB7IHstJoEfKqHdgKIM4CfWsuUt7fM6UYcZgrd-9D4zHojJASHuOUOgaLX3wWPZ5qM7NbqKsVZebBAAmOPmO20tdGOlcU50WId8iUMECbPCz3YlOXLpW6Ql8i1EnOKCSJFfHLuMtBVxmfdk
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
            //TODO: Parse an API error response
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
