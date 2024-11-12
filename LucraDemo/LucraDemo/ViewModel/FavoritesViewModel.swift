//
//  FavoritesViewModel.swift
//  LucraDemo
//
//  Created by Phillip English on 11/11/24.
//

import Foundation
import SwiftData
import SwiftUI

protocol FavoritesViewModelProtocol: Observable {
    var favorites: [Album] { get set }
    func loadFavorites()
}

@Observable
class FavoritesViewModel: FavoritesViewModelProtocol {
    var favorites: [Album] = []
    var modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        loadFavorites()  // Initial load of favorites
    }
    
    func loadFavorites() {
        let sortDescriptor = SortDescriptor(\Album.title)
        let fetchDescriptor = FetchDescriptor<Album>(sortBy: [sortDescriptor])
        
        do {
            favorites = try modelContext.fetch(fetchDescriptor)
        } catch {
            favorites = []
        }
    }
    
    @objc private func refreshFavorites() {
        loadFavorites()
    }
}
