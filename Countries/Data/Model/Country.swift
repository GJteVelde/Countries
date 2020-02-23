//
//  Country.swift
//  Countries
//
//  Created by Gerrit Jan te Velde on 09.02.20.
//  Copyright © 2020 Gerrit Jan te Velde. All rights reserved.
//

import Foundation

struct Country: Codable {
    
    var alpha3Code: String
    var alpha2Code: String?
    
    var name: String?
    var capital: String?
    var region: String?
    var subregion: String?
}

extension Country: Identifiable {
    
    var id: String {
        return alpha3Code
    }
}
