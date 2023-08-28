//
//  TVShow.swift
//  BragiMovies
//
//  Created by Gazdag Sandor on 2023. 08. 22..
//

import Foundation

struct TVShow: Codable, Equatable {
    let id: Int
    let name: String
    let voteAverage: Double
    let backdropPath: String?
    let lastAirDate: String?
    let lastEpisodeToAir: TVShowEpisode?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case voteAverage = "vote_average"
        case backdropPath = "backdrop_path"
        case lastAirDate = "last_air_date"
        case lastEpisodeToAir = "last_episode_to_air"
    }
    
    static func == (lhs: TVShow, rhs: TVShow) -> Bool {
        lhs.id == rhs.id
    }
}
