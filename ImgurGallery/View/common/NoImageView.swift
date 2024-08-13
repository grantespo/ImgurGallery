//
//  NoImageView.swift
//  ImgurGallery
//
//  Created by Grant Espanet on 8/12/24.
//

import SwiftUI

/// Displays a placeholder when no image is available.
struct NoImageView: View {
    let width: CGFloat = 100
    let height: CGFloat = 100
    
    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(Color.gray.opacity(0.3))
            .frame(width: width, height: height)
            .overlay(
                Text("No Image")
                    .foregroundColor(.gray)
                    .font(.caption)
            )
    }
}
