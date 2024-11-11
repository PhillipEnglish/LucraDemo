//
//  GalleryView.swift
//  LucraDemo
//
//  Created by Phillip English on 11/10/24.
//

import SwiftUI

struct GalleryView: View {
    var album: Album
    
    @State private var selectedImageIndex: Int = 0  // Tracks the currently displayed image
    
    var body: some View {
        ZStack {
            // Gradient background
            LinearGradient(
                gradient: Gradient(colors: [.lucraBlue, .lucraGreen]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .edgesIgnoringSafeArea(.all)
            
            // Carousel view with centered images
            TabView(selection: $selectedImageIndex) {
                ForEach(Array(album.images.enumerated()), id: \.element.id) { index, image in
                    ZoomableImageView(url: image.link)
                        .tag(index)
                        .padding()
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))  // Center index indicator
        }
        .navigationTitle(album.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ZoomableImageView: View {
    let url: URL
    @State private var scale: CGFloat = 1.0  // Zoom scale
    
    var body: some View {
        GeometryReader { geometry in
            AsyncImage(url: url) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .scaleEffect(scale)
                    .gesture(
                        MagnificationGesture()
                            .onChanged { value in
                                scale = value
                            }
                            .onEnded { _ in
                                // Reset the scale after zooming
                                withAnimation {
                                    scale = 1.0
                                }
                            }
                    )
            } placeholder: {
                ProgressView()
                    .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
    }
}
