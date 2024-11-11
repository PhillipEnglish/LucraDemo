//
//  AlbumCardView.swift
//  LucraDemo
//
//  Created by Phillip English on 11/10/24.
//

import SwiftUI
import SwiftData

struct AlbumCardView: View {
    @Bindable var viewModel: AlbumCardViewModel
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(alignment: .center, spacing: 10) {
                // Display the album image, or show a placeholder if it fails or is empty
                AsyncImage(url: viewModel.albumCoverURL()) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 200, height: 200)
                            .cornerRadius(10)
                    case .failure(_), .empty:
                        Rectangle() // Placeholder if no image or load failure
                            .fill(Color.gray)
                            .frame(width: 200, height: 200)
                            .cornerRadius(10)
                            .overlay(
                                Text("No Image")
                                    .font(.caption)
                                    .foregroundColor(.white)
                            )
                    @unknown default:
                        ProgressView()
                            .frame(width: 100, height: 150)
                            .background(Color.gray)
                            .cornerRadius(10)
                    }
                }
                
                Text(viewModel.albumCardText())
                    .font(.headline)
                    .foregroundColor(.white)
                    .lineLimit(2)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding([.leading, .trailing], 5)
                    .padding(.top, 5)
                    .padding(.bottom, viewModel.album.images.isEmpty ? 20 : 0) // Add extra bottom padding if no image
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 10)
            .background(Color.blue)
            .cornerRadius(10)
            .shadow(radius: 4)
            
            // Favorite button
            Button(action: {
                viewModel.toggleFavorite()
            }) {
                Image(systemName: viewModel.isFavorite ? "star.fill" : "star")
                    .foregroundColor(.yellow)
                    .padding(10)
            }
        }
    }
}

