//
//  TMDBRepository.swift
//  BragiMovies
//
//  Created by Gazdag Sandor on 2023. 08. 21..
//

import Foundation
import RxSwift

protocol TMDBRepositoryProtocol {
    
    func listGenres(for mediaType: MediaType) -> Single<Genres>
        
    func listMedia<Item: Codable>(for mediaType: MediaType, with genreID: Int, page: Int) -> Single<ListPage<Item>>
    func mediaDetails<Item: Codable>(for mediaType: MediaType, with mediaID: Int) -> Single<Item>
}

class TMDBRepository: TMDBRepositoryProtocol {

    let apiKey: String
    let apiClient: APIClientProtocol
    
    init(apiKey: String, apiClient: APIClientProtocol) {
        self.apiKey = apiKey
        self.apiClient = apiClient
    }
    
    func listGenres(for mediaType: MediaType) -> Single<Genres> {
        let request = APIRequest(method: .get, path: "/genre/\(mediaType.rawValue)/list")
        request.queryItems = [URLQueryItem(name: "language", value: "en")]
        request.headers = [
            HTTPHeader(
                field: "Authorization:",
                value: "Bearer " + apiKey
            )
        ]
        return apiClient.perform(request)
    }

    func listMedia<Item: Codable>(for mediaType: MediaType, with genreID: Int, page: Int) -> Single<ListPage<Item>> {
        let request = APIRequest(method: .get, path: "/discover/\(mediaType.rawValue)")
        request.queryItems = [
            URLQueryItem(name: "language", value: "en"),
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "with_genres", value: "\(genreID)"),
            URLQueryItem(name: "sort_by", value: "popularity.desc")

        ]
        request.headers = [
            HTTPHeader(
                field: "Authorization:",
                value: "Bearer " + apiKey
            )
        ]
        return apiClient.perform(request)
    }
    
    func mediaDetails<Item: Codable>(for mediaType: MediaType, with mediaID: Int) -> Single<Item> {
        let request = APIRequest(method: .get, path: "/\(mediaType.rawValue)/\(mediaID)")
        request.queryItems = [
            URLQueryItem(name: "language", value: "en"),
            URLQueryItem(name: "append_to_response", value: "discover"),

        ]
        request.headers = [
            HTTPHeader(
                field: "Authorization:",
                value: "Bearer " + apiKey
            )
        ]
        return apiClient.perform(request)
    }
    
}

//    Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3ZjU0YWQxZWE0ZmI0YzVmMDczMjFjZDUyZDJmMzBlMCIsInN1YiI6IjU4OWNjNjg3YzNhMzY4MTE1ODAwMTc0MSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.-vWmnNb68dUwPtyzuGsQzszxj1nshCDJvMf0EBqOaZk
