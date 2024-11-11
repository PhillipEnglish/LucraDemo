//
//  AlbumCardViewModel.swift
//  LucraDemo
//
//  Created by Phillip English on 11/10/24.
//

import Foundation
import SwiftUI
import SwiftData

protocol AlbumCardViewModelProtocol: Observable {
    var album: Album { get set }
    var isFavorite: Bool { get }
    func toggleFavorite()
    func albumCoverURL() -> URL
    func albumCardText() -> String
}

@Observable
class AlbumCardViewModel: AlbumCardViewModelProtocol {
    var album: Album
    var isFavorite: Bool = false
    private var modelContext: ModelContext
    
    private var albumPredicate: Predicate<Album> {
        let albumID = album.id
        let albumPredicate = #Predicate<Album> {$0.id == albumID}
        return albumPredicate
       }
    
    init(album: Album, modelContext: ModelContext) {
        self.album = album
        self.modelContext = modelContext
        checkIfFavorite() // Check if this album is already favorited
    }
    
    func toggleFavorite() {
        Task {
            if isFavorite {
                await unfavoriteAlbum()
            } else {
                await favoriteAlbum()
            }
        }
    }
    
    private func favoriteAlbum() async {
        do {
            modelContext.insert(album) // Insert album into SwiftData
            try modelContext.save() // Persist the change
            isFavorite = true // Update local state
        } catch {
            print("Failed to favorite album: \(error)")
        }
    }
    
    private func unfavoriteAlbum() async {
        do {
            try modelContext.delete(model: Album.self, where: albumPredicate)
            try modelContext.save() // Persist the deletion
            isFavorite = false // Update local state
        } catch {
            print("Failed to unfavorite album: \(error)")
        }
    }
    
    private func checkIfFavorite() {
        // Check if the album already exists in SwiftData
        let fetchDescriptor = FetchDescriptor<Album>(predicate: albumPredicate)
        do {
            let results = try modelContext.fetch(fetchDescriptor)
            isFavorite = !results.isEmpty // Update favorite status
        } catch {
            print("Failed to check if album is favorite: \(error)")
        }
    }
    
    func albumCoverURL() -> URL {
        return album.images.first?.link ?? URL(string: "https://en.wikipedia.org/wiki/Kitten#/media/File:Juvenile_Ragdoll.jpg")!
    }
    
    func albumCardText() -> String {
        let truncatedTitle = album.title.count > 45 ? "\(album.title.prefix(45))..." : album.title
        let imageCountText = album.images.count == 1 ? "1 image" : "\(album.images.count) images"
        return "\(truncatedTitle): \(imageCountText)"
    }
}
