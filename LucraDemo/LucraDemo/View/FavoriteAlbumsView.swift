//
//  FavoriteAlbumsView.swift
//  LucraDemo
//
//  Created by Phillip English on 11/10/24.
//

import SwiftUI

struct FavoritesListView: View {
    @Bindable var viewModel: AlbumViewModel
    
    var body: some View {
            NavigationView {
                Group {
//                    if viewModel.favorites.isEmpty {
//                        Text("You haven't selected any favorites")
//                            .font(.headline)
//                            .foregroundColor(.gray)
//                            .padding()
//                            .multilineTextAlignment(.center)
//                    } else {
//                        ScrollView {
//                            LazyVStack {
//                                ForEach(viewModel.favorites) { album in
//                                    NavigationLink(destination: GalleryView(viewModel: GalleryViewModel(album: album))) {
//                                        AlbumCardView(viewModel: AlbumCardViewModel(album: album))
//                                            .cornerRadius(10)
//                                            .shadow(radius: 5)
//                                    }
//                                }
//                            }
//                            .padding(.horizontal)
//                        }
//                    }
                }
            }
            .navigationTitle("Favorites")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                //$viewModel.fetchFavorites
            }
    }
}



