//
//  NetworkingClient.swift
//  ImgurGallery
//
//  Created by Grant Espanet on 8/13/24.
//

import Foundation

/// A client responsible for handling network requests using URLSession.
class NetworkingClient {
    
    private let urlSession: URLSession
    
    init() {
        // Configure URLSession with the specified timeout.
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 5.0
        configuration.timeoutIntervalForResource = 5.0
        self.urlSession = URLSession(configuration: configuration)
    }
    
    /// Fetches data from the specified URL with optional HTTP headers.
    ///
    /// - Parameters:
    ///   - url: The URL to fetch data from.
    ///   - headers: A dictionary of HTTP headers to include in the request. Defaults to an empty dictionary.
    /// - Returns: The raw data received from the network request.
    /// - Throws: An error if the network request fails, such as a timeout or invalid response.
    func fetchData(from url: URL, headers: [String: String] = [:]) async throws -> Data {
        // Create a URLRequest with the provided URL.
        var request = URLRequest(url: url)
        
        // Add the provided headers to the request.
        headers.forEach { key, value in
            request.addValue(value, forHTTPHeaderField: key)
        }
        
        // Perform the network request asynchronously.
        let (data, response) = try await urlSession.data(for: request)
        
        // Ensure the response is a valid HTTP response with a status code in the 200-299 range.
        guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }
        
        return data
    }
}
