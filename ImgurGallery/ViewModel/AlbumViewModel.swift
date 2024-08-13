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
    private let networkingClient = NetworkingClient()
        
    init() {
        searchCancellable = $query
            .debounce(for: .seconds(debounceDelay), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] newValue in
                guard let self = self else { return }
                if newValue.isEmpty {
                    self.albums = []
                    self.errorMessage = nil
                } else {
                    Task {
                        await self.fetchAlbums()
                    }
                }
            }
    }

    func fetchAlbums() async {
        guard !query.isEmpty else {
            albums = []
            errorMessage = nil
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        do {
            guard let url = URL(string: ImgurAPI.baseURL + "gallery/search?q_all=\(query)&q_type=album") else { return }
            
            let headers = ["Authorization": "Client-ID " + Secrets.imgurClientId]
            let data = try await networkingClient.fetchData(from: url, headers: headers)
            let response = try JSONDecoder().decode(ImgurResponse.self, from: data)
            albums = filterOutVideoContent(albums: response.data)
            
            if albums.isEmpty {
                errorMessage = "No albums found."
            }
        } catch {
            print("\(error)")
            errorMessage = "Failed to load albums. \(error.localizedDescription)"
        }
                
        isLoading = false
    }
}
