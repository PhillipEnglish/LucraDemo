//
//  NetworkClient.swift
//  LucraDemo
//
//  Created by Phillip English on 11/10/24.
//

import Foundation

import Foundation

class NetworkClient {
    private static let cache = URLCache(memoryCapacity: 50 * 1024 * 1024, diskCapacity: 100 * 1024 * 1024, diskPath: nil)
    
    static func fetch<T: Codable>(request: URLRequest) async throws -> T {
        if let cachedResponse = cache.cachedResponse(for: request) {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: cachedResponse.data)
        }
        
        return try await withCheckedThrowingContinuation { continuation in
            Task.detached {
                do {
                    let (data, response) = try await URLSession.shared.data(for: request)
                    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                        throw URLError(.badServerResponse)
                    }
                    
                    let cachedData = CachedURLResponse(response: response, data: data)
                    cache.storeCachedResponse(cachedData, for: request)
                    
                    let decoder = JSONDecoder()
                    let decodedData = try decoder.decode(T.self, from: data)
                    continuation.resume(returning: decodedData)
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}


