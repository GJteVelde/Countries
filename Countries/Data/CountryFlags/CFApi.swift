//
//  CFApi.swift
//  Countries
//
//  Created by Gerrit Jan te Velde on 18.02.20.
//  Copyright © 2020 Gerrit Jan te Velde. All rights reserved.
//

import Foundation

//Example CountryFlags: https://www.countryflags.io/be/shiny/64.png

enum CFApi {
    
    case fetchFlag(id: String)
    
}

extension CFApi: API {
    
    var method: String {
        return "GET"
    }
    
    var scheme: String {
        return "https"
    }
    
    var host: String {
        return "countryflags.io"
    }
    
    var path: String {
        var path = "/"
        
        switch self {
        case .fetchFlag(id: let id):       path += "\(id)"
        }
        
        path += "/shiny/64.png"
        
        return path
    }
    
    var parameters: [URLQueryItem] {
        return []
    }
}
