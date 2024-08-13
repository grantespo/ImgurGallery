//
//  AlbumListViewRow.swift
//  ImgurGallery
//
//  Created by Grant Espanet on 8/12/24.
//

import SwiftUI

struct AlbumListViewRow: View {
    @State private var isFavorite = false
    let album: Album
    
    var body: some View {
        HStack(spacing: 8) {
            
            if let cover = album.cover {
                AsyncImageView(url: "\(ImgurAPI.imageURL)\(cover).jpg", cornerRadius: 8, width: 100, height: 100)
            } else {
                NoImageView()
            }
            
            VStack(alignment: .leading, spacing: 2) {
                Text(album.title ?? "Album")
                    .font(.headline)
                    .foregroundColor(.primary)
                    .lineLimit(2)
                
                let imageCount = album.images?.count ?? 0
                
                Text("\(imageCount) image\(imageCount == 1 ? "" : "s")")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Button(action: {
                withAnimation(.easeInOut(duration: 0.15)) {
                    isFavorite.toggle()
                }
                // TODO
            }) {
                Image(systemName: isFavorite ? "heart.fill" : "heart")
                    .resizable()
                    .foregroundColor(.red)
                    .frame(width: 24, height: 24)
                    .padding(.trailing, 8)
            }
            .buttonStyle(PlainButtonStyle())
            .contentShape(Rectangle())
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 0)
        .frame(height: 100)
        .background(
            Color(UIColor { traitCollection in
                traitCollection.userInterfaceStyle == .dark ? UIColor.systemGray5 : UIColor.systemGray6
            })
            .cornerRadius(8)
        )
    }
}
