//
//  ObservableType+Extension.swift
//  BragiMovies
//
//  Created by Gazdag Sandor on 2023. 08. 28..
//

import Foundation
import RxSwift

public enum CodableError: Error {
    case dataMissing
    case decoding(Error?)
}

extension ObservableType {
    
    public func mapObject<T: Codable>(type: T.Type) -> Observable<T> {
        return flatMap { data -> Observable<T> in
            let responseTuple = data as? (HTTPURLResponse, Data)
            guard let jsonData = responseTuple?.1 else { throw CodableError.dataMissing}
            let decoder = JSONDecoder()
            do {
                let object = try decoder.decode(T.self, from: jsonData)
                return Observable.just(object)
            } catch let error {
                throw CodableError.decoding(error)
            }
        }
    }
}
