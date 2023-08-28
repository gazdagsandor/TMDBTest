//
//  ListState.swift
//  BragiMovies
//
//  Created by Gazdag Sandor on 2023. 08. 22..
//

import Foundation

enum ListState {
    case initialized
    case finishedLoadingGenres
    case genreChange(from: Int?, to: Int?)
    case loading(page: Int)
    case loaded(page: Page)
}
