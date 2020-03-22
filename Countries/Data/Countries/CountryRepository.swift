//
//  CountryRepository.swift
//  Countries
//
//  Created by Gerrit Jan te Velde on 09.03.20.
//  Copyright © 2020 Gerrit Jan te Velde. All rights reserved.
//

import Foundation
import Combine

struct CountryRepository<RemoteStore: Store, LocalStore: Store>: Store where RemoteStore.Object == Country, LocalStore.Object == Country {
    
    let remoteStore: RemoteStore
    let localStore: LocalStore
    
    typealias Object = Country
    
    //TODO: Return Realm data in case of error
    func getAll() -> AnyPublisher<[Country], Error> {
        remoteStore.getAll()
            .handleEvents(receiveOutput: { (countries) in
                countries.forEach { self.insert($0) }
            })
            .eraseToAnyPublisher()
    }
    
    @discardableResult
    func insert(_ item: Country) -> AnyPublisher<Country, Error> {
            localStore.insert(item)
    }
    
    func getById(_ id: String) -> AnyPublisher<Country, Error> {
        fatalError("getById() not implemented for repository.")
    }
}
