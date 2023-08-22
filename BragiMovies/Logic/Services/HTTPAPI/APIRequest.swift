//
//  APIRequest.swift
//  BragiMovies
//
//  Created by Gazdag Sandor on 2023. 08. 21..
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
    case head = "HEAD"
    case options = "OPTIONS"
    case trace = "TRACE"
    case connect = "CONNECT"
}

struct HTTPHeader {
    let field: String
    let value: String
}

class APIRequest {
    let method: HTTPMethod
    let path: String
    var queryItems: [URLQueryItem]?
    var headers: [HTTPHeader]?
    var body: Data?
    
    init(method: HTTPMethod, path: String) {
        self.method = method
        self.path = path
    }
    
    init<RequestBody: Encodable>(method: HTTPMethod, path: String, body: RequestBody) throws {
        self.method = method
        self.path = path
        self.body = try JSONEncoder().encode(body)
    }
}
