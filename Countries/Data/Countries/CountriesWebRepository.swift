//
//  CountriesRepository.swift
//  Countries
//
//  Created by Gerrit Jan te Velde on 11.02.20.
//  Copyright © 2020 Gerrit Jan te Velde. All rights reserved.
//

import Foundation
import Combine

class CountriesWebRepository: CountriesRepository {
    
    private let networker: CountriesNetworker
    
    init(networker: CountriesNetworker = CountriesNetworker.shared) {
        self.networker = networker
    }
    
    func getAll() -> AnyPublisher<[Country], Error> {
        networker.fetchAll()
    }
    
    func get(id: String) -> AnyPublisher<Country, Error> {
        networker.fetch(id: id)
    }
}
