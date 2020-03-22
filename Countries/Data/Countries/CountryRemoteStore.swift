//
//  CountryRemoteStore.swift
//  Countries
//
//  Created by Gerrit Jan te Velde on 09.03.20.
//  Copyright © 2020 Gerrit Jan te Velde. All rights reserved.
//

import Foundation
import Combine

struct CountryRemoteStore: Store {
    
    typealias Object = Country
    
    private var networking: Networking
    
    init(networking: Networking) {
        self.networking = networking
    }
    
    func getAll() -> AnyPublisher<[Country], Error> {
        let api = RCApi.fetchAll
        
        return networking.fetch(api: api)
            .decode(type: [Country].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func getById(_ id: String) -> AnyPublisher<Country, Error> {
        fatalError("getById() not implemented for remote store.")
    }
    
    @discardableResult
    func insert(_ item: Country) -> AnyPublisher<Country, Error> {
        fatalError("insert() not implemented for remote store.")
    }
    
}
