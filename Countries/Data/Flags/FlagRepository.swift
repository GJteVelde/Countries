//
//  FlagRepository.swift
//  Countries
//
//  Created by Gerrit Jan te Velde on 21.03.20.
//  Copyright © 2020 Gerrit Jan te Velde. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

struct FlagRepository<RemoteStore: Store>: Store where RemoteStore.Object == Image {
    
    let remoteStore: RemoteStore
    
    typealias Object = Image
    
    
    
    func getById(_ id: String) -> AnyPublisher<Image, Error> {
        remoteStore.getById(id)
    }
    
    func getAll() -> AnyPublisher<[Image], Error> {
        fatalError("getAll() not implemented for repository.")
    }
    
    func insert(_ item: Image) -> AnyPublisher<Image, Error> {
        fatalError("insert() not implemented for repository.")
    }
    
}
