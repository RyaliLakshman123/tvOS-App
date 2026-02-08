//
//  Movie.swift
//  TV
//
//  Created by Sameer Nikhil on 15/12/25.
//

import Foundation

struct Movie: Codable, Identifiable {
    let id: Int
    let title: String
    let overview: String
    let backdropPath: String?
    let trailerKey: String?

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case backdropPath = "backdrop_path"
        //Don't include trailerKey here since it's not from API
    }
    
    //DD CUSTOM DECODER
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        overview = try container.decode(String.self, forKey: .overview)
        backdropPath = try container.decodeIfPresent(String.self, forKey: .backdropPath)
        trailerKey = nil  // Default to nil when decoding from API
    }
    
    //ADD CUSTOM INITIALIZER FOR MANUAL CREATION
    init(id: Int, title: String, overview: String, backdropPath: String?, trailerKey: String?) {
        self.id = id
        self.title = title
        self.overview = overview
        self.backdropPath = backdropPath
        self.trailerKey = trailerKey
    }
}
