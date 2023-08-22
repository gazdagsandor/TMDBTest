//
//  Media.swift
//  BragiMovies
//
//  Created by Gazdag Sandor on 2023. 08. 21..
//

import Foundation

struct Movie: Codable, Equatable {
    let id: Int
    let title: String
    let voteAverage: Double
    let voteCount: Int
    let budget: Int?
    let revenue: Int?
    let backdropPath: String?
    let overview: String

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case budget
        case revenue
        case backdropPath = "backdrop_path"
        case overview
    }
    
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        lhs.id == rhs.id
    }

}

