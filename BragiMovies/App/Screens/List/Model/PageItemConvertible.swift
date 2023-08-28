//
//  PageItemConvertible.swift
//  BragiMovies
//
//  Created by Gazdag Sandor on 2023. 08. 22..
//

import Foundation

protocol PageItemConvertible: Codable {
    var id: Int { get }
    func toPageItem() -> PageItem
}

extension Movie: PageItemConvertible {
    func toPageItem() -> PageItem {
        .from(
            input: .movie(
                id: id,
                title: title,
                voteAverage: voteAverage,
                budget: budget,
                revenue: revenue,
                imageURL: URL(string: "https://image.tmdb.org/t/p/w500" + (backdropPath ?? "")))
        )
    }
}

extension TVShow: PageItemConvertible {
    func toPageItem() -> PageItem {
        .from(
            input: .tvShow(
                id: id,
                title: name,
                voteAverage: voteAverage,
                lastAirDate: lastAirDate,
                lastEpisodeToAir: lastEpisodeToAir?.name,
                imageURL: URL(string: "https://image.tmdb.org/t/p/w500" + (backdropPath ?? "")))
        )
    }
}


