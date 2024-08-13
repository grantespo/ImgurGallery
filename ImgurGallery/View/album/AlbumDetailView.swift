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
            
        }
        .navigationTitle(album.title ?? "Album")
    }
}
