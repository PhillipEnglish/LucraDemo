//
//  AlbumViewModel.swift
//  LucraDemo
//
//  Created by Phillip English on 11/10/24.
//

import Foundation
import SwiftData

/// A protocol defining the requirements for an album search view model, isolated to the main actor.
@MainActor
protocol AlbumViewModelProtocol: Observable {
    var albums: [Album] { get }
    var searchQuery: String { get set }
    var isLoading: Bool { get }
    var errorMessage: String? { get }
    
    func fetchAlbums() async
    func resetAlbums()
    
    // Favorites Management
    func isFavorite(_ album: Album) -> Bool
    func toggleFavorite(for album: Album)
    func fetchFavorites() -> [Album]
}

@Observable
class AlbumViewModel: AlbumViewModelProtocol {
    
    // MARK: - Properties
    private let networkingService: NetworkingServiceProtocol
    var albums: [Album] = []
    var searchQuery: String = ""
    var isLoading: Bool = false
    var errorMessage: String?
    
    private let favoritesKey = "favoritedAlbumIDs"
    private var favoritedAlbumIDs: Set<String> {
        get {
            return Set(UserDefaults.standard.stringArray(forKey: favoritesKey) ?? [])
        }
        set {
            UserDefaults.standard.set(Array(newValue), forKey: favoritesKey)
        }
    }
    
    // MARK: - Initialization
    
    init(networkingService: NetworkingServiceProtocol = NetworkingService()) {
        self.networkingService = networkingService
    }
    
    // MARK: - Methods
    
    func fetchAlbums() async {
        guard searchQuery.count > 1 else {
            resetAlbums()
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        do {
            albums = try await networkingService.fetchAlbums(for: searchQuery)
            print("Fetched \(albums.count) albums")
        } catch {
            errorMessage = "Failed to load albums. Please try again."
            print("Error fetching albums: \(error)")
        }
        
        isLoading = false
    }
    
    func resetAlbums() {
        albums.removeAll()
    }
    
    // MARK: - Favorites Management
    
    func isFavorite(_ album: Album) -> Bool {
        return favoritedAlbumIDs.contains(album.id)
    }
    
    func toggleFavorite(for album: Album) {
        if isFavorite(album) {
            favoritedAlbumIDs.remove(album.id)
        } else {
            favoritedAlbumIDs.insert(album.id)
        }
    }
    
    func fetchFavorites() -> [Album] {
        return albums.filter { isFavorite($0) }
    }
}


