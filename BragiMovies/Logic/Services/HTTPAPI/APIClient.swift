//
//  APIClient.swift
//  BragiMovies
//
//  Created by Gazdag Sandor on 2023. 08. 21..
//

import Foundation
import RxSwift
import RxCocoa

protocol APIClientProtocol {
    
    func perform<ResponseType: Codable>(
        _ request: APIRequest
    ) -> Single<ResponseType>
}

class APIClient: APIClientProtocol {
    
    private let session: URLSession
    private let baseURL: URL
    private let decoder: JSONDecoder
    
    init(baseURL: URL, session: URLSession = URLSession.shared, decoder: JSONDecoder = JSONDecoder()) {
        self.baseURL = baseURL
        self.session = session
        self.decoder = decoder
    }
    
    func perform<ResponseType: Codable>(
        _ request: APIRequest
    ) -> Single<ResponseType> {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = baseURL.scheme
        urlComponents.host = baseURL.host
        urlComponents.path = baseURL.path
        urlComponents.queryItems = request.queryItems
        
        guard let url = urlComponents.url?.appendingPathComponent(request.path) else {
            return .error(APIError.invalidURL)
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.httpBody = request.body
        
        request.headers?.forEach { urlRequest.addValue($0.value, forHTTPHeaderField: $0.field) }
        
        return session.rx
            .response(request: urlRequest)
            .mapObject(type: ResponseType.self)
            .asSingle()
    }
}
