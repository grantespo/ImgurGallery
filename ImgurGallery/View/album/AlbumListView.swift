//
//  AlbumListView.swift
//  ImgurGallery
//
//  Created by Grant Espanet on 8/12/24.
//

import SwiftUI

/// Displays a list of albums with search functionality.
struct AlbumListView: View {
    @StateObject var viewModel = AlbumViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBarView(text: $viewModel.query, onTypingChanged: { isTyping in
                    viewModel.isTyping = isTyping
                })
                
                if viewModel.isLoading {
                    Spacer()
                    ProgressView()
                        .scaleEffect(2)
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                    Spacer()
                } else if let errorMessage = viewModel.errorMessage {
                    Spacer()
                    Text(errorMessage)
                        .font(.body)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 50)
                    Spacer()
                } else if viewModel.query.isEmpty {
                    Spacer()
                    Text("Please enter a search term to find albums.")
                        .font(.body)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 50)
                    Spacer()
                } else {
                    List {
                        ForEach(viewModel.albums) { album in
                            ZStack {
                                AlbumListViewRow(album: album, viewModel: viewModel)
                                // Invisible navigation link to the album detail view.
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
            }.background(
                BackgroundGradient()
            )
            .navigationTitle("Albums")
        }
    }
}
