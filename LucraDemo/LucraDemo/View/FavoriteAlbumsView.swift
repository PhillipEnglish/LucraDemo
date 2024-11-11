//
//  FavoriteAlbumsView.swift
//  LucraDemo
//
//  Created by Phillip English on 11/10/24.
//

import SwiftUI

struct FavoritesListView: View {
    @Bindable var viewModel: FavoritesViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                // Gradient background
                LinearGradient(
                    gradient: Gradient(colors: [.lucraRoyalBlue, .lucraBlue, .lucraBlueWhite, .lucraGreen]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .edgesIgnoringSafeArea(.all)
                
                if viewModel.favorites.isEmpty {
                    Text("You haven't selected any favorites")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .padding()
                        .multilineTextAlignment(.center)
                } else {
                    ScrollView {
                        LazyVStack {
                            ForEach(viewModel.favorites) { album in
                                NavigationLink(destination: GalleryView(viewModel: GalleryViewModel(album: album))) {
                                    AlbumCardView(viewModel: AlbumCardViewModel(album: album, modelContext: viewModel.modelContext))
                                        .cornerRadius(10)
                                        .shadow(radius: 5)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .navigationTitle("Favorites")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                viewModel.loadFavorites()
            }
        }
    }
}





