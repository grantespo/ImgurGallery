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
    let images: [ImageData]?
}

// Image model
struct ImageData: Decodable, Identifiable {
    let id: String
    let title: String?
    let description: String?
    let link: String
    let width: Int
    let height: Int
}
