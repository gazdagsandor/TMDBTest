//
//  Genre+Extensions.swift
//  BragiMovies
//
//  Created by Gazdag Sandor on 2023. 08. 22..
//

import Foundation

extension Genre: Equatable {
    static func == (lhs: Genre, rhs: Genre) -> Bool {
        lhs.id == rhs.id
    }
}
