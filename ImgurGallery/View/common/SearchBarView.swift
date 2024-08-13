//
//  SearchBarView.swift
//  ImgurGallery
//
//  Created by Grant Espanet on 8/12/24.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var text: String
    @FocusState private var isTextFieldFocused: Bool
    var onTypingChanged: (Bool) -> Void // Callback to notify when typing starts/stops
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            TextField("Search Albums", text: $text)
                .focused($isTextFieldFocused)
                .onChange(of: isTextFieldFocused) { _, isFocused in
                    onTypingChanged(isFocused)
                }
                .onSubmit {
                    isTextFieldFocused = false // Dismiss keyboard on return
                }
        }
        .padding(10)
        .background(
            Color(UIColor { traitCollection in
                traitCollection.userInterfaceStyle == .dark ? UIColor.systemGray5 : UIColor.systemGray6
            })
        )
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.systemGray4), lineWidth: 1)
        )
        .padding(.horizontal)
    }
}

struct SearchBarView_Previews: PreviewProvider {
    @State static var text = ""
    static var previews: some View {
        SearchBarView(text: $text, onTypingChanged: { _ in })
            .preferredColorScheme(.light)
        SearchBarView(text: $text, onTypingChanged: { _ in })
            .preferredColorScheme(.dark)
    }
}
