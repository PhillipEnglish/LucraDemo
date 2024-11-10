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
    let images: [Image]
    
    /// Custom coding keys to match the Imgur API's JSON structure.
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case images
    }
}

/// Represents an individual image in an album, with an ID and URL link.
struct Image: Codable, Identifiable {
    let id: String
    let link: URL
    
    /// Custom coding keys for the Image structure.
    private enum CodingKeys: String, CodingKey {
        case id
        case link
    }
}
