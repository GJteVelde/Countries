//
//  FlagRemoteStore.swift
//  Countries
//
//  Created by Gerrit Jan te Velde on 21.03.20.
//  Copyright © 2020 Gerrit Jan te Velde. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

struct FlagRemoteStore: Store {
    
    typealias Object = Image
    
    private var networking: Networking
    
    init(networking: Networking) {
        self.networking = networking
    }
    
    func getById(_ id: String) -> AnyPublisher<Image, Error> {
        let api = CFApi.fetchFlag(id: id)
        
        return networking.fetch(api: api)
            .tryMap { (data) in
                guard let uiImage = UIImage(data: data) else {
                    throw DataError.invalidData
                }
                return Image(uiImage: uiImage)
            }
            .eraseToAnyPublisher()
    }
    
    @discardableResult
    func getAll() -> AnyPublisher<[Image], Error> {
        fatalError("getAll() not implemented for remote store.")
    }
    
    @discardableResult
    func insert(_ item: Image) -> AnyPublisher<Image, Error> {
        fatalError("insert() not implemented for remote store.")
    }
}
