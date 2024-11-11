//
//  Album.swift
//  LucraDemo
//
//  Created by Phillip English on 11/10/24.
//

import Foundation

/// Represents an album from the Imgur API, containing the album's ID, title, and a collection of images.
struct Album: Codable, Identifiable {
    let id: String
    let title: String
    let images: [AlbumImage]
}

/// Represents an individual image in an album, with an ID and URL link.
struct AlbumImage: Codable, Identifiable {
    let id: String
    let link: URL
    let type: String
}
