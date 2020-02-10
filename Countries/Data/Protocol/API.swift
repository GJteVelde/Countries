//
//  API.swift
//  Countries
//
//  Created by Gerrit Jan te Velde on 10.02.20.
//  Copyright © 2020 Gerrit Jan te Velde. All rights reserved.
//

import Foundation

protocol API {
    
    var method: String { get }
    
    var scheme: String { get }
    
    var host: String { get }
    
    var path: String { get }
    
    var parameters: [URLQueryItem] { get }
    
}
