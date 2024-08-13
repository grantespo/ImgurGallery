//
//  AlbumViewModel.swift
//  ImgurGallery
//
//  Created by Grant Espanet on 8/12/24.
//

import Combine
import Foundation

@MainActor
class AlbumViewModel: ObservableObject {
    @Published var albums: [Album] = []
    @Published var query: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var isTyping: Bool = false
    
    private var searchCancellable: AnyCancellable?
    private var debounceDelay: TimeInterval = 0.5
    
    private let imgurClientId = Config.imgurClientId
    
    init() {
        searchCancellable = $query
            .debounce(for: .seconds(debounceDelay), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] newValue in
                guard let self = self, !isLoading, !newValue.isEmpty, isTyping else {return}
                Task {
                    await self.fetchAlbums()
                    self.isTyping = false // Mark typing as false after the search is triggered
                }
            }
    }

    func fetchAlbums() async {
        guard !query.isEmpty else {
            albums = []
            errorMessage = nil
            return
        }
        
        print("fetching albums...")
        isLoading = true
        errorMessage = nil
        
        do {
            guard let url = URL(string: ImgurAPI.baseURL + ImgurAPI.gallerySearch + "q_all=\(query)&" + "q_type=album") else { return }
            
            var request = URLRequest(url: url)
            request.addValue("Client-ID \(imgurClientId)", forHTTPHeaderField: "Authorization")

            let (data, _) = try await URLSession.shared.data(for: request)
            let response = try JSONDecoder().decode(ImgurResponse.self, from: data)
            albums = response.data
            
            if albums.isEmpty {
                errorMessage = "No albums found."
            }
            print("done fetching albums...")
        } catch {
            errorMessage = "Failed to load albums. Please try again."
            print("done fetching albums with error...")
        }
                
        isLoading = false
    }
}
