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

#if DEBUG
extension Country {
    
    static var Netherlands = Country(alpha3Code: "NLD",
                                     alpha2Code: "NL",
                                     name: "The Netherlands",
                                     capital: "Amsterdam",
                                     region: "Europe",
                                     subregion: "Western Europe")
    
    static var Antarctica = Country(alpha3Code: "ANT",
                                    alpha2Code: "AN",
                                    name: "Antarctica",
                                    capital: nil,
                                    region: nil,
                                    subregion: nil)
}
#endif
