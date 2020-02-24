//
//  RestCountriesApi.swift
//  Countries
//
//  Created by Gerrit Jan te Velde on 10.02.20.
//  Copyright © 2020 Gerrit Jan te Velde. All rights reserved.
//

import Foundation

//Example RestCountries: https://restcountries.eu/rest/v2/all

/// RestCountriesAPI
enum RCApi {
    
    case fetchAll
    case fetch(id: String)
    
}

extension RCApi: API {
    
    var method: String {
        return "GET"
    }
    
    var scheme: String {
        return "https"
    }
    
    var host: String {
        return "restcountries.eu"
    }
    
    var path: String {
        
        var base = "/rest/v2/"
        
        switch self {
        case .fetchAll:             base += "all"
        case .fetch(id: let id):    base += "alpha/\(id)"
        }
        
        return base
        
    }
    
    var parameters: [URLQueryItem] {
        return []
    }
}
