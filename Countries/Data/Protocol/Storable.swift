//
//  Storable.swift
//  Countries
//
//  Created by Gerrit Jan te Velde on 09.03.20.
//  Copyright © 2020 Gerrit Jan te Velde. All rights reserved.
//

import Foundation

///All models which need to be stored in the database should implement `Entity` protocol. `Storable` is used to store the actual data in the database.
protocol Storable {
    
    associatedtype EntityObject: Entity
    
    var model: EntityObject { get }
    
    var id: String { get }
    
}
