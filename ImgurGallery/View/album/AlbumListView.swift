//
//  AlbumListView.swift
//  ImgurGallery
//
//  Created by Grant Espanet on 8/12/24.
//

import SwiftUI

struct AlbumListView: View {
    @StateObject var viewModel = AlbumViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBarView(text: $viewModel.query, onTypingChanged: { isTyping in
                    viewModel.isTyping = isTyping
                })
                
                if viewModel.isLoading || (viewModel.isTyping && !viewModel.query.isEmpty) {
                    Spacer()
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                    Spacer()
                } else if let errorMessage = viewModel.errorMessage {
                    Spacer()
                    Text(errorMessage)
                        .font(.body)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding()
                    Spacer()
                } else if viewModel.albums.isEmpty || viewModel.query.isEmpty {
                    Spacer()
                    Text(viewModel.query.isEmpty ? "Please enter a search term to find albums." : "No albums found")
                        .font(.body)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding()
                    Spacer()
                } else {
                    List {
                        ForEach(viewModel.albums) { album in
                            ZStack {
                                AlbumListViewRow(album: album)
                                NavigationLink(destination: AlbumDetailView(album: album)) {
                                    EmptyView()
                                }.opacity(0)
                            }
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                        }
                    }
                    .listStyle(PlainListStyle())
                    .background(Color.clear)
                }
            }
            .navigationTitle("Albums")
            .background(Color(UIColor { traitCollection in
                traitCollection.userInterfaceStyle == .dark ? UIColor.black : UIColor.white
            }))
        }
    }
}
