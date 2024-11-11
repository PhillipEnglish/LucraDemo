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
    @State private var searchTask: Task<Void, Never>? = nil
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Loading albums")
                        .padding()
                } else if viewModel.albums.isEmpty {
                    Text("No albums found")
                        .foregroundColor(.blue)
                        .padding()
                } else {
                    ScrollView {
                        LazyVStack {
                            ForEach(viewModel.albums) { album in
                                NavigationLink(destination: GalleryView(album: album)) {
                                    AlbumCardView(viewModel: AlbumCardViewModel(album: album))
                                        .cornerRadius(10)
                                        .shadow(radius: 5)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .navigationTitle("Imgur Albums")
            .searchable(text: $searchQuery, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search albums")
            .onChange(of: searchQuery) { newQuery in
                if newQuery.count > 1 {
                    // Cancel any ongoing task
                    searchTask?.cancel()
                    
                    // Start a new throttled search task
                    searchTask = Task {
                        // Wait for a short delay to throttle search requests
                        try? await Task.sleep(nanoseconds: 300 * 1_000_000)  // 300 milliseconds
                        if !Task.isCancelled {
                            await viewModel.fetchAlbums(for: newQuery)
                        }
                    }
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
