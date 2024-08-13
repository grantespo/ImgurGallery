//
//  FullScreenImageView.swift
//  ImgurGallery
//
//  Created by Grant Espanet on 8/12/24.
//

import Kingfisher
import SwiftUI

struct FullscreenImageView: View {
    let image: ImageData
    
    @State private var currentScale: CGFloat = 1.0
    @State private var lastScale: CGFloat = 1.0
    @State private var offset: CGSize = .zero
    @State private var lastOffset: CGSize = .zero
    
    let minScale: CGFloat = 1.0
    let maxScale: CGFloat = 4.0
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 16) {
                // Fullscreen Image
                KFImage(URL(string: image.link))
                    .placeholder {
                        ProgressView()
                    }
                    .resizable()
                    .aspectRatio(contentMode: .fit) // Adjusts to fit within the view and center
                    .clipped()
                    .scaleEffect(currentScale)
                    .offset(x: offset.width, y: offset.height)
                    .gesture(
                        MagnificationGesture()
                            .onChanged { value in
                                currentScale = min(max(minScale, lastScale * value), maxScale)
                            }
                            .onEnded { value in
                                currentScale = min(max(minScale, currentScale), maxScale)
                                lastScale = currentScale
                                adjustOffset(for: geometry.size)
                            }
                            .simultaneously(with: DragGesture()
                                .onChanged { value in
                                    let newOffset = CGSize(
                                        width: lastOffset.width + value.translation.width,
                                        height: lastOffset.height + value.translation.height
                                    )
                                    offset = newOffset
                                    adjustOffset(for: geometry.size)
                                }
                                .onEnded { value in
                                    lastOffset = offset
                                    adjustOffset(for: geometry.size)
                                }
                            )
                    )
                    .aspectRatio(contentMode: .fit) // Ensures the image fits and is centered
                    .frame(width: geometry.size.width)
                    .padding(.top, 90)
                
                Spacer()
            }
            .padding(.top)
            .edgesIgnoringSafeArea(.all)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ViewsStack(views: image.views)
                .padding(.top, 5)
            }
        }
    }
    
    private func adjustOffset(for size: CGSize) {
        let imageSize = CGSize(width: size.width * currentScale, height: size.height * currentScale)
        let maxXOffset = (imageSize.width - size.width) / 2
        let maxYOffset = (imageSize.height - size.height) / 2
        
        var newOffset = offset
        
        if newOffset.width > maxXOffset {
            newOffset.width = maxXOffset
        } else if newOffset.width < -maxXOffset {
            newOffset.width = -maxXOffset
        }
        
        if newOffset.height > maxYOffset {
            newOffset.height = maxYOffset
        } else if newOffset.height < -maxYOffset {
            newOffset.height = -maxYOffset
        }
        
        offset = newOffset
    }
}
