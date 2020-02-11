
//
//  RCRepository.swift
//  Countries
//
//  Created by Gerrit Jan te Velde on 11.02.20.
//  Copyright © 2020 Gerrit Jan te Velde. All rights reserved.
//

import Foundation
import Combine

protocol RCRepository {
    
    func getAll() -> AnyPublisher<[Country], Error>
    
    func get(id: String) -> AnyPublisher<Country, Error>
    
}
