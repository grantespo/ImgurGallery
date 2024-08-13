//
//  BackgroundGradient.swift
//  ImgurGallery
//
//  Created by Grant Espanet on 8/13/24.
//


import SwiftUI

struct BackgroundGradient: View {
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(colorScheme == .light ? 0.2 : 0.1), colorScheme == .light ? .white : .gray]), startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
    }
}
