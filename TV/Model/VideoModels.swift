//
//  VideoModels.swift
//  TV
//
//  Created by Sameer Nikhil on 15/12/25.
//

import Foundation

struct VideoResponse: Codable {
    let results: [Video]
}

struct Video: Codable, Identifiable {
    let id: String
    let key: String
    let name: String
    let site: String
    let type: String
    let official: Bool
}

// TMDBConfig.swift

enum TMDBConfig {
    static let apiKey = "YOUR_ACTUAL_TMDB_API_KEY"
}
