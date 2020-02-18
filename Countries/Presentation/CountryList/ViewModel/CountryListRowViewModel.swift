//
//  CountryListRowViewModel.swift
//  Countries
//
//  Created by Gerrit Jan te Velde on 09.02.20.
//  Copyright © 2020 Gerrit Jan te Velde. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class CountryListRowViewModel: ObservableObject {
    
    var country: Country
    
    @Published var flag: Image? = nil
    
    private var cancellable = Set<AnyCancellable>()
    
    private let repository: CFRepository
    
    init(country: Country, repository: CFRepository = CFWebRepository()) {
        self.country = country
        self.repository = repository
    }
    
    var name: String {
        return country.name ?? "Unknown"
    }
    
    func fetchFlag() {
        guard let alpha2Code = country.alpha2Code else { return }
        
        repository.get(id: alpha2Code)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { (completion) in
                switch completion {
                case .finished:
                    print("✅ finished for \(alpha2Code).")
                case .failure(let error):
                    print("❌ \(error.localizedDescription)")
                }
            }) { (image) in
                self.flag = image
            }
            .store(in: &cancellable)
    }
}

extension CountryListRowViewModel: Identifiable {
    var id: String {
        return country.id
    }
}
