//
//  AsyncImageView.swift
//  ImgurGallery
//
//  Created by Grant Espanet on 8/12/24.
//

import Kingfisher
import SwiftUI

/// Loads the image asynchronously with Kingfisher, display a `ProgressView` while loading,
/// and applies optional image processing for better performance when displaying in lists.
struct AsyncImageView: View {
    let url: String
    var cornerRadius: CGFloat = 0
    var width: CGFloat = 100
    var height: CGFloat = 100
    var useProcessor: Bool = false // set to true when loading from lists for better optimization
    
    var body: some View {
        KFImage(URL(string: url))
            .placeholder {
                ProgressView()
            }
            .setProcessor(useProcessor ? ResizingImageProcessor(referenceSize: CGSize(width: width * 2, height: height * 2), mode: .aspectFill) : DefaultImageProcessor()) 
            .cancelOnDisappear(true)
            .loadDiskFileSynchronously()
            .cacheOriginalImage()
            .resizable()
            .scaledToFill()
            .frame(width: width, height: height)
            .cornerRadius(cornerRadius)
            .clipped()
    }
}
