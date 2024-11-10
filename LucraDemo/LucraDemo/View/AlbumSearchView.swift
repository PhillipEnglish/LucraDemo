//
//  ContentView.swift
//  LucraDemo
//
//  Created by Phillip English on 11/9/24.
//

import SwiftUI

struct AlbumSearchView: View {
    var viewModel: AlbumViewModel
    @State private var searchQuery = ""
    @State private var showingFavorites = false
    @State private var showAlert = false

    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading albums…")
                        .padding()
                } else if viewModel.albums.isEmpty {
                    Text("No albums found. Try a different search.")
                        .foregroundColor(.secondary)
                        .padding()
                } else {
                    List {
                        ForEach(viewModel.albums, id: \.id) { album in
                            NavigationLink(destination: GalleryView(album: album)) {
                                AlbumCardView(album: album)
                                    .cornerRadius(10)
                                    .shadow(radius: 5)
                            }
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Imgur Albums")
            .searchable(text: $searchQuery, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search albums")
            .onChange(of: searchQuery) { newQuery in
                viewModel.searchQuery = newQuery
                Task {
                    await viewModel.fetchAlbums()
                }
            }
            .toolbar {
                Button("Favorites") {
                    showingFavorites = true
                }
            }
            .sheet(isPresented: $showingFavorites) {
                FavoritesListView(viewModel: viewModel)
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Error"), message: Text(viewModel.errorMessage ?? "An unknown error occurred."), dismissButton: .default(Text("OK")))
            }
            .onAppear {
                if viewModel.errorMessage != nil {
                    showAlert = true
                }
            }
        }
    }
}


struct AlbumSearchView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumSearchView(viewModel: AlbumViewModel())
    }
}
