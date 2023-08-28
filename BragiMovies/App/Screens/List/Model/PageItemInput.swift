//
//  PageItemInput.swift
//  BragiMovies
//
//  Created by Gazdag Sandor on 2023. 08. 28..
//

import Foundation

enum PageItemInput {
    
    case movie(
        id: Int,
        title: String,
        voteAverage: Double,
        budget: Int?,
        revenue: Int?,
        imageURL: URL?
    )
    case tvShow(
        id: Int,
        title: String,
        voteAverage: Double,
        lastAirDate: String?,
        lastEpisodeToAir: String?,
        imageURL: URL?
    )
}
