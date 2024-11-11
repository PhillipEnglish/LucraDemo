//
//  AlbumCardView.swift
//  LucraDemo
//
//  Created by Phillip English on 11/10/24.
//

import SwiftUI

struct AlbumCardView: View {
    let viewModel: AlbumCardViewModel
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            // Display the first image as the album cover
            AsyncImage(url: viewModel.albumCoverURL()) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 200)
                        .cornerRadius(10)
                        .transition(.scale.combined(with: .opacity))
                        .transition(.scale.combined(with: .opacity))
                        .frame(width: 200, height: 200)
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
                Text(viewModel.albumCardText())
                    .font(.headline)
                    .foregroundColor(.lucraBlueWhite)
                    .lineLimit(2)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding([.leading, .trailing], 5)
                    .padding(.top, 5)
        }
        .padding(.horizontal, 8).padding(.vertical, 10)
        .background(Color.lucraBlue)
        .cornerRadius(10)
        .shadow(radius: 4)
    }
}


