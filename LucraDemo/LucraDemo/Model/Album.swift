//
//  Album.swift
//  LucraDemo
//
//  Created by Phillip English on 11/10/24.
//

import Foundation
import SwiftData

/// Represents an album from the Imgur API, containing the album's ID, title, and a collection of images.
@Model
class Album: Identifiable, Codable {
    @Attribute(.unique) let id: String
    let title: String
    let images: [AlbumImage]
    
    init(id: String, title: String, images: [AlbumImage]) {
        self.id = id
        self.title = title
        self.images = images
    }
    
    // Custom decoding implementation
    private enum CodingKeys: String, CodingKey {
        case id, title, images
    }
    
    required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let id = try container.decode(String.self, forKey: .id)
        let title = try container.decode(String.self, forKey: .title)
        let images = try container.decode([AlbumImage].self, forKey: .images)
        self.init(id: id, title: title, images: images)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        // Manually encode each property
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(images, forKey: .images)
    }
}

/// Represents an individual image in an album, with an ID and URL link.
struct AlbumImage: Codable, Identifiable {
    let id: String
    let link: URL
    let type: String
}
