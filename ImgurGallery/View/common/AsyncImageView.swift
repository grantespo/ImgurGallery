//
//  AsyncImageView.swift
//  ImgurGallery
//
//  Created by Grant Espanet on 8/12/24.
//

import Kingfisher
import SwiftUI

struct AsyncImageView: View {
    let url: String
    let width: CGFloat = 100
    let height: CGFloat = 100
    var body: some View {
        KFImage(URL(string: url))
            .placeholder {
                ProgressView()
            }
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: width, height: height)
            .cornerRadius(8)
    }
}
