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
    @State private var lastQuery = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [.lucraBlue, .lucraGreen]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .edgesIgnoringSafeArea(.all)
                
                VStack {
                    if viewModel.isLoading {
                        ProgressView("Loading albums")
                            .padding()
                    } else if viewModel.albums.isEmpty {
                        Text("No albums found")
                            .foregroundColor(.white)
                            .padding()
                    } else {
                        ScrollView {
                            LazyVStack() {
                                ForEach(viewModel.albums) { album in
                                    NavigationLink(destination: GalleryView(viewModel: GalleryViewModel(album: album))) {
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
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Imgur Albums")
                            .font(.headline)
                            .foregroundColor(Color.lucraBlueWhite)
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            showingFavorites = true
                        }) {
                            Text("Favorites")
                                .foregroundColor(Color.lucraBlueWhite) // Customize the button color
                        }
                    }
                }
                .searchable(text: $searchQuery, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search albums")
                .onSubmit(of: .search) {
                    viewModel.fetchAlbums(for: searchQuery)
                }
                .onChange(of: searchQuery) { newQuery in
                    if newQuery.count < 1 {
                        viewModel.resetAlbums()
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
                .scrollDismissesKeyboard(.immediately)
                // Dismiss keyboard when tapping outside
            }
            .onTapGesture {
                UIApplication.shared.endEditing()
            }
        }
    }
}


struct AlbumSearchView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumSearchView(viewModel: AlbumViewModel())
    }
}
