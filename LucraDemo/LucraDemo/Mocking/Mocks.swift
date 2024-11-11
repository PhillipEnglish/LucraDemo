//
//  Mocks.swift
//  LucraDemo
//
//  Created by Phillip English on 11/11/24.
//

import Foundation
import SwiftUI
import SwiftData

// Mock version of the APIServiceProtocol
class MockAPIService: APIServiceProtocol {
    var shouldFail = false
    var mockAlbums: [Album] = []
    
    func fetchAlbums(for query: String) async throws -> [Album] {
        if shouldFail {
            throw URLError(.badServerResponse)
        }
        return mockAlbums
    }
}

class MockAlbumViewModel: AlbumViewModelProtocol {
    var albums: [Album] = []
    var isLoading: Bool = false
    var errorMessage: String?
    private var shouldFail = false
    
    init(shouldFail: Bool = false) {
        self.shouldFail = shouldFail
    }
    
    func fetchAlbums(for query: String) async {
        isLoading = true
        if shouldFail {
            errorMessage = "Failed to load albums."
        } else {
            albums = [Album(id: "1", title: "Test Album", images: [AlbumImage(id: "1", link: URL(string: "https://example.com")!, type: "image/jpeg")])]
        }
        isLoading = false
    }
    
    func resetAlbums() {
        albums = []
    }
}

class MockFavoritesViewModel: FavoritesViewModelProtocol {
    var favorites: [Album] = []
    
    func loadFavorites() {
        favorites = [Album(id: "1", title: "Favorite Album", images: [])]
    }
}

class MockGalleryViewModel: GalleryViewModelProtocol {
    var albumTitle: String = "Gallery Album"
    var images: [AlbumImage] = [AlbumImage(id: "1", link: URL(string: "https://example.com")!, type: "image/jpeg")]
    var selectedImageIndex: Int = 0
}

class MockAlbumCardViewModel: AlbumCardViewModelProtocol {
    var album: Album
    var isFavorite: Bool = false
    
    init(album: Album) {
        self.album = album
    }
    
    func toggleFavorite() {
        isFavorite.toggle()
    }
    
    func albumCoverURL() -> URL {
        return album.images.first?.link ?? URL(string: "https://example.com/placeholder.jpg")!
    }
    
    func albumCardText() -> String {
        let truncatedTitle = album.title.count > 45 ? "\(album.title.prefix(45))..." : album.title
        let imageCountText = album.images.count == 1 ? "1 image" : "\(album.images.count) images"
        return "\(truncatedTitle): \(imageCountText)"
    }
}



