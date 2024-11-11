//
//  NetworkClient.swift
//  LucraDemo
//
//  Created by Phillip English on 11/10/24.
//

import Foundation

class NetworkClient {
    private static let cache = URLCache.shared
    
    static func fetch<T: Codable>(request: URLRequest) async throws -> T {
        let decoder = JSONDecoder()
        
        //Check if using cached response
        if let cachedResponse = cache.cachedResponse(for: request) {
            return try decoder.decode(T.self, from: cachedResponse.data)
        }
        
        // Fetch from network
        let (data, response) = try await URLSession.shared.data(for: request)
         guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        
        //Validate status code and response
        guard httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        // Store in cache
        let cachedData = CachedURLResponse(response: response, data: data)
        cache.storeCachedResponse(cachedData, for: request)
        
        // Decode JSON response
        return try decoder.decode(T.self, from: data)
    }
}
