//
//  AlbumCardViewModel.swift
//  LucraDemo
//
//  Created by Phillip English on 11/10/24.
//

import Foundation

protocol AlbumCardViewModelProtocol: Observable {
    var album: Album { get set }
    func albumCoverURL() -> URL
    func albumCardText() -> String
}

@Observable
class AlbumCardViewModel: AlbumCardViewModelProtocol {
    var album: Album
    
    init(album: Album) {
        self.album = album
    }
    
    func albumCoverURL() -> URL {
        if let albumImage = album.images.first?.link {
            return albumImage
        } else {
            return URL(string: "https://en.wikipedia.org/wiki/Kitten#/media/File:Juvenile_Ragdoll.jpg")!
        }
    }
    
    func albumCardText() -> String {
        let truncatedTitle = album.title.count > 45 ? "\(album.title.prefix(45))..." : album.title
        let imageCountText = album.images.count == 1 ? "1 image" : "\(album.images.count) images"
        return "\(truncatedTitle): \(imageCountText)"
    }
}