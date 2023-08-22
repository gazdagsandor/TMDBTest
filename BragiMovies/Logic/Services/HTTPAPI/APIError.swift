//
//  APIError.swift
//  BragiMovies
//
//  Created by Gazdag Sandor on 2023. 08. 21..
//

import Foundation

public enum APIError: Error {
    case invalidURL
    case requestFailed
    case notFound
    case serverError(String?)
    case decodingFailure
}
