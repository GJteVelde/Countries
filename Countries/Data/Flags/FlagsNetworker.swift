//
//  FlagsNetworker.swift
//  Countries
//
//  Created by Gerrit Jan te Velde on 18.02.20.
//  Copyright © 2020 Gerrit Jan te Velde. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class FlagsNetworker: Networking {
    
    static let shared = FlagsNetworker()
    
    var session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func fetchFlag(id: String) -> AnyPublisher<Image, Error> {
        let api = CFApi.fetchFlag(id: id)
        return self.fetch(api: api)
    }
}

extension FlagsNetworker {
    
    private func fetch(api: CFApi) -> AnyPublisher<Image, Error> {
        guard let urlRequest = createUrlRequest(from: api) else {
            fatalError()
        }
        
        return session.dataTaskPublisher(for: urlRequest)
            .tryMap { (output) in
                guard let uiImage = UIImage(data: output.data) else {
                    fatalError()
                }
                return Image(uiImage: uiImage)
            }
            .eraseToAnyPublisher()
    }
    
}
