//
//  AlbumDetailView.swift
//  ImgurGallery
//
//  Created by Grant Espanet on 8/12/24.
//

import SwiftUI

struct AlbumDetailView: View {
    let album: Album
        
    var body: some View {
        ScrollView {
            Text(album.title ?? "Album")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.horizontal)
                .frame(maxWidth: .infinity, alignment: .leading)
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 10) {
                ForEach(album.images ?? [], id: \.id) { image in
                    NavigationLink(destination: FullscreenImageView(image: image)) {
                        AsyncImageView(url: image.link)
                    }
                }
            }
            .padding()
        }
    }
}
