//
//  dateformatter.swift
//  ImgurGallery
//
//  Created by Grant Espanet on 8/13/24.
//

import Foundation

/// Converts epoch time to a formatted date string
func formattedDate(from epochTime: TimeInterval) -> String {
    let date = Date(timeIntervalSince1970: epochTime)
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    return formatter.string(from: date)
}
