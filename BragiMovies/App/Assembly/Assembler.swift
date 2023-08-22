//
//  Assembler.swift
//  BragiMovies
//
//  Created by Gazdag Sandor on 2023. 08. 21..
//

import Foundation

class Assembler {
    
    static let `default` = Assembler()
    
    lazy var apiClient: APIClient = {
        APIClient(baseURL: URL(string: "https://api.themoviedb.org/3")!)
    }()
    
    func tmdbService() -> APIClientProtocol {
        apiClient
    }
}

extension Assembler {

    func tmdbUseCase() -> TMDBUseCaseProtocol {
        return TMDBUseCase(
            tmdbRepository: tmdbRepository(
                apiKey: "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3ZjU0YWQxZWE0ZmI0YzVmMDczMjFjZDUyZDJmMzBlMCIsInN1YiI6IjU4OWNjNjg3YzNhMzY4MTE1ODAwMTc0MSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.-vWmnNb68dUwPtyzuGsQzszxj1nshCDJvMf0EBqOaZk"
            )
        )
    }
}

extension Assembler {

    func tmdbRepository(apiKey: String) -> TMDBRepositoryProtocol {
        return TMDBRepository(apiKey: apiKey, apiClient: tmdbService())
    }
}
