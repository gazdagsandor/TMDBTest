//
//  TMDBUseCase.swift
//  BragiMovies
//
//  Created by Gazdag Sandor on 2023. 08. 21..
//

import Foundation
import RxSwift

protocol TMDBUseCaseProtocol {
    
    func listGenres(for mediaType: MediaType) -> Single<[Genre]>
    func listMedia<Item: Codable>(for mediaType: MediaType, with genreID: Int, page: Int) -> Single<ListPage<Item>>
    func mediaDetails<Item: Codable>(for mediaType: MediaType, with mediaID: Int) -> Single<Item>
}

class TMDBUseCase: TMDBUseCaseProtocol {
    
    var tmdbRepository: TMDBRepositoryProtocol
    
    init(tmdbRepository: TMDBRepositoryProtocol) {
        self.tmdbRepository = tmdbRepository
    }
    
    func listGenres(for mediaType: MediaType) -> Single<[Genre]> {
        tmdbRepository.listGenres(for: mediaType).map(\.genres)
    }
    
    func listMedia<Item: Codable>(for mediaType: MediaType, with genreID: Int, page: Int) -> Single<ListPage<Item>> {
        tmdbRepository.listMedia(for: mediaType, with: genreID, page: page)
    }
    
    func mediaDetails<Item: Codable>(for mediaType: MediaType, with mediaID: Int) -> Single<Item> {
        return tmdbRepository.mediaDetails(for: mediaType, with: mediaID).retry(3)
    }
}
