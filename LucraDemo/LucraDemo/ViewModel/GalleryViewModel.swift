//
//  GalleryViewModel.swift
//  LucraDemo
//
//  Created by Phillip English on 11/11/24.
//

import Foundation
import SwiftUI

protocol GalleryViewModelProtocol: Observable {
    var albumTitle: String { get }
    var images: [Image] { get }
    var selectedImageIndex: Int { get set }
}

@Observable
class GalleryViewModel: GalleryViewModelProtocol {
    private let album: Album
    var selectedImageIndex: Int = 0
    
    init(album: Album) {
        self.album = album
    }
    
    var albumTitle: String {
        album.title
    }
    
    var images: [Image] {
        album.images
    }
}
