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
                apiKey: "7f54ad1ea4fb4c5f07321cd52d2f30e0"
            )
        )
    }
}

extension Assembler {

    func tmdbRepository(apiKey: String) -> TMDBRepositoryProtocol {
        return TMDBRepository(apiKey: apiKey, apiClient: tmdbService())
    }
}
