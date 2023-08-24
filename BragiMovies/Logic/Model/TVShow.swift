//
//  TVShow.swift
//  BragiMovies
//
//  Created by Gazdag Sandor on 2023. 08. 22..
//

import Foundation

struct TVShow: Codable, Equatable, Identifiable {
    let id: Int
    let name: String
    let voteAverage: Double
    let backdropPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case voteAverage = "vote_average"
        case backdropPath = "backdrop_path"
    }
    
    static func == (lhs: TVShow, rhs: TVShow) -> Bool {
        lhs.id == rhs.id
    }
}
