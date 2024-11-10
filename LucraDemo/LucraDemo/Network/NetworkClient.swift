//
//  NetworkClient.swift
//  LucraDemo
//
//  Created by Phillip English on 11/10/24.
//

import Foundation

/// A simple network client for fetching and decoding JSON data.
/// Use this to send a network request and get a decoded response in one step.
///
/// - Example:
/// ```swift
/// let request = URLRequest(url: URL(string: "https://api.example.com/data")!)
/// let result: MyModel = try await NetworkClient.fetch(request: request)
/// ```
///
/// - Note: The type `T` must conform to `Codable` to support decoding.
///
/// - Throws: An error if the request fails or if the data can't be decoded.
class NetworkClient {
    /// Fetches data from a URLRequest and decodes it to a given Codable type.
    ///
    /// - Parameter request: The `URLRequest` to send.
    /// - Returns: A decoded object of type `T`.
    /// - Throws: An error if fetching or decoding fails.
    static func fetch<T: Codable>(request: URLRequest) async throws -> T {
        let (data, _) = try await URLSession.shared.data(for: request)
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
}
