//
//  FavoriteAlbumsView.swift
//  LucraDemo
//
//  Created by Phillip English on 11/10/24.
//

import SwiftUI

struct FavoritesListView: View {
    var viewModel: AlbumViewModel
    
    var body: some View {
        Text("hello world")
//        NavigationView {
//            if viewModel.fetchFavorites().isEmpty {
//                Text("You haven't added any favorites yet")
//                    .foregroundColor(.secondary)
//                    .navigationTitle("Favorites")
//            } else {
//                List(viewModel.fetchFavorites(), id: \.id) { album in
//                    NavigationLink(destination: GalleryView(album: album)) {
//                        AlbumCardView(album: album)
//                    }
//                }
//                .onAppear {
//                    // Pre-fetch the favorites when the view appears
//                    _ = viewModel.fetchFavorites()
//                }
//                .navigationTitle("Favorites")
//            }
//        }
    }
}
