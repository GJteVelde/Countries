//
//  CountryLocalStore.swift
//  Countries
//
//  Created by Gerrit Jan te Velde on 11.03.20.
//  Copyright © 2020 Gerrit Jan te Velde. All rights reserved.
//

import Foundation
import Combine
import RealmSwift

struct CountryLocalStore: Store {
    
    typealias Object = Country
    
    private let realm: Realm
    
    init() {
        realm = try! Realm()
    }
    
    func getAll() -> AnyPublisher<[Country], Error> {
        
        return Future { promise in
            DispatchQueue.main.async {
                let lazyObjects = self.realm.objects(Country_Realm.self)
                promise(.success(
                    lazyObjects.compactMap { $0.model }
                ))
            }
        }.eraseToAnyPublisher()
        
    }
    
    @discardableResult
    func insert(_ item: Country) -> AnyPublisher<Country, Error> {
        
        return Future { promise in
            DispatchQueue.main.async {
                do {
                    try self.realm.write {
                        self.realm.add(item.toStorable(), update: .modified)
                    }
                    promise(.success(item))
                } catch {
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
        
    }
    
    func getById(_ id: String) -> AnyPublisher<Country, Error> {
        fatalError("getById() not implemented for local store.")
    }
}
