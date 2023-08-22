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
        PageItem(
            id: id,
            title: title,
            voteAverage: voteAverage,
            budget: budget ?? .zero,
            revenue: revenue ?? .zero,
            imageURL: URL(string: "https://image.tmdb.org/t/p/w500" + (backdropPath ?? ""))
        )
    }
}

extension TVShow: PageItemConvertible {
    func toPageItem() -> PageItem {
        PageItem(
            id: id,
            title: name,
            voteAverage: voteAverage,
            budget: .zero,
            revenue: .zero,
            imageURL: URL(string: "https://image.tmdb.org/t/p/w500" + (backdropPath ?? ""))
        )
    }
}
