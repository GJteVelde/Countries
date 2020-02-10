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
 
    func fetchAll() -> AnyPublisher<[Country], Error> {
        let api = RCApi.fetchAll
        return self.fetch(api: api)
    }
    
}
