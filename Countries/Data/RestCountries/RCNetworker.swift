//
//  RCNetworker.swift
//  Countries
//
//  Created by Gerrit Jan te Velde on 10.02.20.
//  Copyright © 2020 Gerrit Jan te Velde. All rights reserved.
//

import Foundation
import Combine

class RCNetworker: Networking {
 
    var session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func fetchAll() -> AnyPublisher<[Country], Error> {
        let api = RCApi.fetchAll
        return self.fetch(api: api)
    }
    
    func fetch(id: String) -> AnyPublisher<Country, Error> {
        let api = RCApi.fetch(id: id)
        return self.fetch(api: api)
    }
}
