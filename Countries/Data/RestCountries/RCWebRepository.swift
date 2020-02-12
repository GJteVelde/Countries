//
//  RCWebRepository.swift
//  Countries
//
//  Created by Gerrit Jan te Velde on 11.02.20.
//  Copyright © 2020 Gerrit Jan te Velde. All rights reserved.
//

import Foundation
import Combine

class RCWebRepository: RCRepository {
    
    typealias T = Country
    
    private let networker: Networking
    
    init(networker: Networking = RCNetworker.shared) {
        self.networker = networker
    }
    
    func getAll() -> AnyPublisher<[T], Error> {
        networker.fetch(api: RCApi.fetchAll)
    }
    
    func get(id: String) -> AnyPublisher<T, Error> {
        networker.fetch(api: RCApi.fetch(id: id))
    }
}
