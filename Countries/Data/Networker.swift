//
//  Networker.swift
//  Countries
//
//  Created by Gerrit Jan te Velde on 11.03.20.
//  Copyright © 2020 Gerrit Jan te Velde. All rights reserved.
//

import Foundation

class Networker: Networking {
    
    var session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
}
