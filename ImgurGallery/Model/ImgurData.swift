//
//  ImgurData.swift
//  ImgurGallery
//
//  Created by Grant Espanet on 8/12/24.
//

import Foundation

// Root Response
struct ImgurResponse: Decodable {
    let data: [Album]
}

// Album model
struct Album: Decodable, Identifiable {
    let id: String
    let title: String?
    let description: String?
    let cover: String?
    var images: [ImageData]?
    var views: Int
}

// Image model
struct ImageData: Decodable, Identifiable {
    let id: String
    let title: String?
    let description: String?
    let type: String?
    let link: String
    let width: CGFloat
    let height: CGFloat
    var views: Int
}

func filterOutVideoContent(albums: [Album]) -> [Album] {
    return albums.map { album in
        var filteredAlbum = album
        // Safely unwrap the optional images array and apply the filter
        if let images = album.images {
            // Assign the filtered array back to the album
            filteredAlbum.images = images.filter {
                return $0.type != "video/mp4"
            }
        }
        return filteredAlbum
    }.filter { album in
        // Filter out albums with no remaining images
        return album.images?.isEmpty == false
    }
}
