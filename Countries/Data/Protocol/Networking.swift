//
//  Networking.swift
//  Countries
//
//  Created by Gerrit Jan te Velde on 10.02.20.
//  Copyright © 2020 Gerrit Jan te Velde. All rights reserved.
//

import Foundation
import Combine

protocol Networking { }

extension Networking {
    
    func fetch<T: Decodable>(api: API) -> AnyPublisher<T, Error> {
        guard let urlRequest = createUrlRequest(from: api) else {
            fatalError()
        }
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .tryMap { (output) in
                print(output.data)
                return output.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    private func createUrlRequest(from api: API) -> URLRequest? {
        
        var components = URLComponents()
        components.scheme = api.scheme
        components.host = api.host
        components.path = api.path
        components.queryItems = api.parameters
        
        guard let url = components.url else { return nil }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = api.method
        return urlRequest
    }
}
