//
//  AlbumViewModel.swift
//  LucraDemo
//
//  Created by Phillip English on 11/10/24.
//

import Foundation
import SwiftData

/// A protocol defining the requirements for an album search view model.
protocol AlbumViewModelProtocol: Observable {
    var albums: [Album] { get set }
    var isLoading: Bool { get set }
    var errorMessage: String? { get set }
    
    func fetchAlbums(for query: String) async
    func resetAlbums()
}

@Observable
class AlbumViewModel: AlbumViewModelProtocol {
    private let networkingService: NetworkingServiceProtocol
    var albums: [Album] = []
    var isLoading: Bool = false
    var errorMessage: String?

    init(networkingService: NetworkingServiceProtocol = NetworkingService()) {
        self.networkingService = networkingService
    }
    
    func fetchAlbums(for query: String)  {
         loadAlbums(for: query)
    }
    
    func loadAlbums(for query: String) {
        isLoading = true
        defer {
            isLoading = false
        }
        
        Task {
            do {
                let newAlbums = try await networkingService.fetchAlbums(for: query)
                albums = newAlbums.filter { album in
                    guard let firstImage = album.images.first else { return false }
                    return !firstImage.type.hasPrefix("video/")
                }
            } catch {
                errorMessage = "Failed to load albums. Please try again."
            }
        }
    }
    
    func resetAlbums() {
        albums.removeAll()
    }
}


