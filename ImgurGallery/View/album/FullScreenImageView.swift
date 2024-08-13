//
//  FullScreenImageView.swift
//  ImgurGallery
//
//  Created by Grant Espanet on 8/12/24.
//

import Kingfisher
import SwiftUI

/// A SwiftUI view that displays an image in fullscreen with pinch-to-zoom and drag-to-pan functionality.
///
/// `FullscreenImageView` allows users to interact with an image by zooming in and out using pinch gestures
/// and panning the image using drag gestures. The view handles the scaling and positioning of the image.
///
/// - Parameter image: The `ImageData` object containing the image's URL and metadata.
struct FullscreenImageView: View {
    let image: ImageData
    
    // States to manage the current scale and offset of the image.
    @State private var currentScale: CGFloat = 1.0
    @State private var lastScale: CGFloat = 1.0
    @State private var offset: CGSize = .zero
    @State private var lastOffset: CGSize = .zero
    
    // Minimum and maximum scaling factors.
    let minScale: CGFloat = 1.0
    let maxScale: CGFloat = 4.0
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 16) {
                KFImage(URL(string: image.link))
                    .placeholder {
                        ProgressView()
                    }
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipped()
                    .scaleEffect(currentScale) // Apply the current scaling factor to the image.
                    .offset(x: offset.width, y: offset.height) // Apply the current offset to the image.
                    .gesture(
                        // Handle pinch-to-zoom gesture.
                        MagnificationGesture()
                            .onChanged { value in
                                currentScale = min(max(minScale, lastScale * value), maxScale)
                            }
                            .onEnded { value in
                                currentScale = min(max(minScale, currentScale), maxScale)
                                lastScale = currentScale
                                adjustOffset(for: geometry.size) // Adjust the offset to keep the image within bounds.
                            }
                            // Handle drag-to-pan gesture simultaneously with pinch-to-zoom.
                            .simultaneously(with: DragGesture()
                                .onChanged { value in
                                    let newOffset = CGSize(
                                        width: lastOffset.width + value.translation.width,
                                        height: lastOffset.height + value.translation.height
                                    )
                                    offset = newOffset
                                    adjustOffset(for: geometry.size) // Adjust the offset during dragging.
                                }
                                .onEnded { value in
                                    lastOffset = offset
                                    adjustOffset(for: geometry.size) // Adjust the offset after dragging ends.
                                }
                            )
                    )
                    .frame(width: geometry.size.width) // Set the frame width to match the screen width.
                    .padding(.top, 90) // Add padding to position the image below the navigation bar.
                
                Spacer()
            }
            .padding(.top)
            .edgesIgnoringSafeArea(.all) // Extend the view to the edges of the screen.
            .navigationBarTitleDisplayMode(.inline) // Display the navigation title in inline mode.
            .toolbar {
                // Display the view count of the image in the toolbar.
                ViewsStack(views: image.views)
                    .padding(.top, 5)
            }
        }.background(
            BackgroundGradient()
        )
    }
    
    /// Adjusts the image offset to ensure it stays within the bounds of the screen.
    ///
    /// This method recalculates the maximum allowed offset based on the current scale and image size,
    /// and adjusts the offset if it exceeds the allowable range.
    ///
    /// - Parameter size: The size of the screen or parent view.
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
