//
//  NetworkingClient.swift
//  ImgurGallery
//
//  Created by Grant Espanet on 8/13/24.
//

import Foundation

class NetworkingClient {
    
    private let urlSession: URLSession
    
    init() {
        // setup timeout
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 5.0
        configuration.timeoutIntervalForResource = 5.0
        self.urlSession = URLSession(configuration: configuration)
    }
    
    func fetchData(from url: URL, headers: [String: String] = [:]) async throws -> Data {
        var request = URLRequest(url: url)
        headers.forEach { key, value in
            request.addValue(value, forHTTPHeaderField: key)
        }
        
        let (data, response) = try await urlSession.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }
        
        return data
    }
}
