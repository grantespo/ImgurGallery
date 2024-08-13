//
//  secrets.swift
//  ImgurGallery
//
//  Created by Grant Espanet on 8/12/24.
//

import Foundation

struct Secrets {
    static let imgurClientId: String = {
        return value(for: "ImgurClientId")
    }()
    
    private static func value(for key: String) -> String {
        guard let filePath = Bundle.main.path(forResource: "Secrets", ofType: "plist") else {
            fatalError("Couldn't find file 'Secrets.plist'.")
        }
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: key) as? String else {
            fatalError("Couldn't find key '\(key)' in 'Secrets.plist'.")
        }
        return value
    }
}
