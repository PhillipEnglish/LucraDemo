//
//  APIService.swift
//  LucraDemo
//
//  Created by Phillip English on 11/10/24.
//

import Foundation

/// A protocol that defines the methods for fetching albums from the Imgur API.
protocol APIServiceProtocol {
    /// Fetches albums based on a given search query.
    /// - Parameter query: The search term used to find relevant albums.
    /// - Returns: An array of `Album` objects that match the query.
    /// - Throws: An error if the request fails or if decoding the data encounters an error.
    func fetchAlbums(for query: String) async throws -> [Album]
}

class APIService: APIServiceProtocol {
    private static let baseURL = "https://api.imgur.com/3/gallery/search"
    private static let clientID = "2d086962f60c89e"
    
    func fetchAlbums(for query: String) async throws -> [Album] {
        guard let url = APIService.constructURL(with: query) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.setValue("Client-ID \(APIService.clientID)", forHTTPHeaderField: "Authorization")
        
        // Debug: Print request details
        print("Making request to:", request.url?.absoluteString ?? "")
        print("Authorization header:", request.value(forHTTPHeaderField: "Authorization") ?? "None")
        
        let response: APIResponse = try await NetworkClient.fetch(request: request)
        return response.data
    }
    
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

