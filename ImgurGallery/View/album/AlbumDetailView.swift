//
//  AlbumDetailView.swift
//  ImgurGallery
//
//  Created by Grant Espanet on 8/12/24.
//

import SwiftUI

/// A SwiftUI view that displays the details of a selected album, including its title and images.
struct AlbumDetailView: View {
    let album: Album
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                let imageCount = album.images?.count ?? 0
                // Album Title
                Text(album.title ?? "Album")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                
                // Album Details
                HStack {
                    Text("Updated on: \(formattedDate(from: TimeInterval(album.datetime)))")
                    Text("•")
                    Text("\(imageCount) image\(imageCount == 1 ? "" : "s")")
                }
                .font(.subheadline)
                .padding(.horizontal)
                .foregroundColor(.secondary)
                
                // Album Description
                if let description = album.description {
                    Text(description)
                        .font(.body)
                        .padding(.horizontal)
                }
                
                // Image Grid
                Text("Photos")
                    .font(.headline)
                    .padding([.horizontal, .top])
                
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 10) {
                    ForEach(album.images ?? [], id: \.id) { image in
                        NavigationLink(destination: FullscreenImageView(image: image)) {
                            AsyncImageView(url: image.link)
                                .aspectRatio(contentMode: .fill)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .shadow(radius: 5)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .background(
            BackgroundGradient()
        )
    }
    
    // Converts epoch time to a formatted date string
    private func formattedDate(from epochTime: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: epochTime)
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}
