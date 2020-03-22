//
//  Store.swift
//  Countries
//
//  Created by Gerrit Jan te Velde on 09.03.20.
//  Copyright © 2020 Gerrit Jan te Velde. All rights reserved.
//

import Foundation
import Combine

protocol Store {
    
    associatedtype Object
    
    func getAll() -> AnyPublisher<[Object], Error>
    
    func getById(_ id: String) -> AnyPublisher<Object, Error>
    
    @discardableResult
    func insert(_ item: Object) -> AnyPublisher<Object, Error>
}
