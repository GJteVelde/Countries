//
//  CFWebRepository.swift
//  Countries
//
//  Created by Gerrit Jan te Velde on 18.02.20.
//  Copyright © 2020 Gerrit Jan te Velde. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class CFWebRepository: CFRepository {
    
    private let networker: CFNetworker
    
    init(networker: CFNetworker = CFNetworker.shared) {
        self.networker = networker
    }
    
    func get(id: String) -> AnyPublisher<Image, Error> {
        networker.fetchFlag(id: id)
    }
}
