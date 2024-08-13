//
//  FullScreenImageView.swift
//  ImgurGallery
//
//  Created by Grant Espanet on 8/12/24.
//

import SwiftUI

struct FullscreenImageView: View {
    let image: ImageData
    @State private var isFavorite: Bool = false
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
                AsyncImageView(url: image.link)
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
                    .padding(.top, 90)
                
                Spacer()
            }
            .padding(.top)
            .background(Color.black)
            .edgesIgnoringSafeArea(.all)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.15)) {
                            isFavorite.toggle()
                        }
                        // TODO: Handle favorite action
                    }) {
                        Image(systemName: isFavorite ? "heart.fill" : "heart")
                            .resizable()
                            .foregroundColor(.red)
                            .frame(width: 24, height: 24)
                    }
                }
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
