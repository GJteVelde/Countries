//
//  Country_Realm.swift
//  Countries
//
//  Created by Gerrit Jan te Velde on 09.03.20.
//  Copyright © 2020 Gerrit Jan te Velde. All rights reserved.
//

import Foundation
import RealmSwift

class Country_Realm: Object {
    
    @objc dynamic var alpha3Code: String = ""
    @objc dynamic var alpha2Code: String?
    
    @objc dynamic var name: String?
    @objc dynamic var capital: String?
    @objc dynamic var region: String?
    @objc dynamic var subregion: String?
    
    override static func primaryKey() -> String? {
        return "alpha3Code"
    }
}

extension Country_Realm: Storable {
    
    var id: String {
        return alpha3Code
    }
    
    var model: Country {
        return Country(alpha3Code      : alpha3Code,
                       alpha2Code      : alpha2Code,
                       name            : name,
                       capital         : capital,
                       region          : region,
                       subregion       : subregion
        )
    }
}
