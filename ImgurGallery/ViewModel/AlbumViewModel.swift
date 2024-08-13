//
//  AlbumViewModel.swift
//  ImgurGallery
//
//  Created by Grant Espanet on 8/12/24.
//

import Combine
import Foundation

/// ViewModel responsible for handling album search functionality and managing the state of the album list.
@MainActor
class AlbumViewModel: ObservableObject {
    
    @Published var albums: [Album] = []
    @Published var query: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var isTyping: Bool = false
    
    /// A cancellable object for handling the debounced search query subscription.
    private var searchCancellable: AnyCancellable?
    
    /// The delay used for debouncing the search query.
    private var debounceDelay: TimeInterval = 0.5
    
    private let networkingClient = NetworkingClient()
    
    /// Initializes a new instance of `AlbumViewModel` and sets up the debounced search query subscription.
    init() {
        // Debounce the search query to avoid making too many API requests while the user is typing.
        searchCancellable = $query
            .debounce(for: .seconds(debounceDelay), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] newValue in
                guard let self = self else { return }
                if newValue.isEmpty {
                    // Clear albums and error message if the query is empty.
                    self.albums = []
                    self.errorMessage = nil
                } else {
                    // Fetch albums based on the new query.
                    Task {
                        await self.fetchAlbums()
                    }
                }
            }
    }

    /// Fetches albums from the API based on the current search query.
    ///
    /// The fetched albums are filtered to remove video content.
    /// If the fetch fails, an error message is displayed.
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
            let response = try JSONDecoder().decode(GalleryResponse.self, from: data)
            
            // Filter out video content from the fetched albums.
            albums = filterOutVideoContent(albums: response.data)
            
            if albums.isEmpty {
                errorMessage = "No albums found."
            }
        } catch {
            errorMessage = "Failed to load albums. \(error.localizedDescription)"
        }
                
        isLoading = false
    }
}
