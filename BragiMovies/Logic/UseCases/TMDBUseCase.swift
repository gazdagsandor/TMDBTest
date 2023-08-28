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
    func listMovies(for mediaType: MediaType, with genreID: Int, page: Int) -> Single<ListPage<Movie>>
    func movieDetails(for mediaType: MediaType, with mediaID: Int) -> Single<Movie>
    func listTVShows(for mediaType: MediaType, with genreID: Int, page: Int) -> Single<ListPage<TVShow>>
    func tvShowDetails(for mediaType: MediaType, with mediaID: Int) -> Single<TVShow>
}

class TMDBUseCase: TMDBUseCaseProtocol {
    
    var tmdbRepository: TMDBRepositoryProtocol
    
    init(tmdbRepository: TMDBRepositoryProtocol) {
        self.tmdbRepository = tmdbRepository
    }
    
    func listGenres(for mediaType: MediaType) -> Single<[Genre]> {
        tmdbRepository.listGenres(for: mediaType)
            .map(\.genres)
    }
    
    func listMovies(for mediaType: MediaType, with genreID: Int, page: Int) -> Single<ListPage<Movie>> {
        let listPage: Observable<ListPage<Movie>> = tmdbRepository.listMedia(for: mediaType, with: genreID, page: page).asObservable()
        return listPage
            .flatMap({ [weak self] page in
                guard let self = self else {
                    return Observable<ListPage<Movie>>.empty().asSingle()
                }
                return Observable.from(
                page.results
                    .compactMap { movie in
                        self.movieDetails(for: mediaType, with: movie.id)
                            .asObservable()
                    }
                )
                .merge()
                .toArray()
                .map { (items: [Movie]) -> ListPage<Movie> in
                    ListPage(
                        page: page.page,
                        results: items,
                        totalPages: page.totalPages,
                        totalResults: page.totalResults
                    )
                }
            })
            .asSingle()
    }
    
    func movieDetails(for mediaType: MediaType, with mediaID: Int) -> Single<Movie> {
        return tmdbRepository.mediaDetails(for: mediaType, with: mediaID)
    }
    
    func listTVShows(for mediaType: MediaType, with genreID: Int, page: Int) -> Single<ListPage<TVShow>> {
        let listPage: Observable<ListPage<TVShow>> = tmdbRepository.listMedia(for: mediaType, with: genreID, page: page).asObservable()
        return listPage
            .flatMap({ [weak self] page in
                guard let self = self else {
                    return Observable<ListPage<TVShow>>.empty().asSingle()
                }
                return Observable.from(
                    page.results
                        .compactMap { tvShow in
                            self.tvShowDetails(for: mediaType, with: tvShow.id)
                                .asObservable()
                        }
                )
                .merge()
                .toArray()
                .map { (items: [TVShow]) -> ListPage<TVShow> in
                    ListPage(
                        page: page.page,
                        results: items,
                        totalPages: page.totalPages,
                        totalResults: page.totalResults
                    )
                }
            })
            .asSingle()
    }
    
    func tvShowDetails(for mediaType: MediaType, with mediaID: Int) -> Single<TVShow> {
        return tmdbRepository.mediaDetails(for: mediaType, with: mediaID)
    }
}
