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
    var cornerRadius: CGFloat = 0
    var width: CGFloat? = nil
    var height: CGFloat? = nil
    var body: some View {
        KFImage(URL(string: url))
            .placeholder {
                ProgressView()
            }
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: width, height: height)
            .cornerRadius(cornerRadius)
            .clipped()
    }
}
