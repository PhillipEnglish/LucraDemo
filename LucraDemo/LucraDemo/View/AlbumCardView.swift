//
//  AlbumCardView.swift
//  LucraDemo
//
//  Created by Phillip English on 11/10/24.
//

import SwiftUI

struct AlbumCardView: View {
    let album: Album
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // Display the first image as the album cover
            if let coverURL = album.images.first?.link {
                AsyncImage(url: coverURL, transaction: Transaction(animation: .easeInOut)) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .cornerRadius(10)
                    case .failure(_):
                        EmptyView()
                    case .empty:
                        ProgressView()
                            .frame(width: 100, height: 150)
                            .background(Color.gray)
                            .cornerRadius(10)
                    @unknown default:
                        ProgressView()
                            .frame(width: 100, height: 150)
                            .background(Color.gray)
                            .cornerRadius(10)
                    }
                }
            }
            Text(album.title)
                .font(.headline)
                .foregroundColor(.primary)
                .lineLimit(2)
                .padding(.top, 10)
                .padding([.leading, .trailing], 5)

            // Display additional album info if desired
            Text("\(album.images.count) images")
                .font(.subheadline)
                .foregroundColor(.secondary)
            .padding(.vertical, 5)
        }
        .padding()
        .background(Color.lucraBlue)
        .cornerRadius(10)
        .shadow(radius: 4)
    }
}
