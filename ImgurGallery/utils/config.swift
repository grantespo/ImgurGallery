//
//  config.swift
//  ImgurGallery
//
//  Created by Grant Espanet on 8/12/24.
//

import Foundation

struct Config {
    static let imgurClientId: String = {
        guard let filePath = Bundle.main.path(forResource: "Secrets", ofType: "plist") else {
            fatalError("Couldn't find file 'Secrets.plist'.")
        }
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "ImgurClientId") as? String else {
            fatalError("Couldn't find key 'ImgurClientId' in 'Secrets.plist'.")
        }
        return value
    }()
}
