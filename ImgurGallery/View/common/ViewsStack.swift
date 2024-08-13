//
//  ViewsStack.swift
//  ImgurGallery
//
//  Created by Grant Espanet on 8/13/24.
//


import SwiftUI

/// used for displaying the `views` for an `Album` or `Image`
struct ViewsStack: View {
    let views: Int
    var body: some View {
        VStack(spacing: 2) {
            Image(systemName: "eye")
                .resizable()
                .foregroundColor(.gray)
                .frame(width: 21, height: 13)
            
            Text("\(views)")
                .font(.caption)
                .foregroundColor(.gray)
                .padding(.top, 3)
        }.padding(.trailing, 8)
    }
}
