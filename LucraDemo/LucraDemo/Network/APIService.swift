//
//  APIService.swift
//  LucraDemo
//
//  Created by Phillip English on 11/10/24.
//

import Foundation

/// A protocol that defines the methods for fetching albums from the Imgur API.
protocol NetworkingServiceProtocol {
    /// Fetches albums based on a given search query.
    /// - Parameter query: The search term used to find relevant albums.
    /// - Returns: An array of `Album` objects that match the query.
    /// - Throws: An error if the request fails or if decoding the data encounters an error.
    func fetchAlbums(for query: String) async throws -> [Album]
}

/// A service responsible for fetching album data from the Imgur API.
class NetworkingService: NetworkingServiceProtocol {
    
    // Base URL and authentication information. Note: In a true production app, I would not hardcode any API auth data
    private static let baseURL = "https://api.imgur.com/3/gallery/search"
    private static let clientID = "2d086962f60c89e"
    
    /// Fetches albums based on a given search query.
    /// - Parameter query: The search term used to find relevant albums.
    /// - Returns: An array of `Album` objects that match the query.
    /// - Throws: An error if the request fails or if decoding the data encounters an error.
    func fetchAlbums(for query: String) async throws -> [Album] {
        // Construct the full URL with query parameters
        guard let url = NetworkingService.constructURL(with: query) else {
            throw URLError(.badURL)
        }
        
        // Set up the request with authorization headers
        var request = URLRequest(url: url)
        request.setValue("Client-ID \(NetworkingService.clientID)", forHTTPHeaderField: "Authorization")
        
        // Fetch the data using the NetworkClient
        let response: APIResponse = try await NetworkClient.fetch(request: request)
        
        return response.data
    }
    
    /// Constructs a URL with the given query parameters.
    /// - Parameter query: The search term to include in the URL query.
    /// - Returns: A fully constructed URL with the base URL, query, and type as "album".
    private static func constructURL(with query: String) -> URL? {
        var components = URLComponents(string: baseURL)
        components?.queryItems = [
            URLQueryItem(name: "q_all", value: query),
            URLQueryItem(name: "q_type", value: "album")
        ]
        return components?.url
    }
}

/// A top-level response structure to match the Imgur API response format.
private struct APIResponse: Codable {
    let data: [Album]
}

