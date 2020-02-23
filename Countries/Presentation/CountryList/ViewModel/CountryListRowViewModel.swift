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
    
    @Published var flag: Image? = nil
    
    @Published var showDetails: Bool = false
    
    private var country: Country
    
    private var cancellable = Set<AnyCancellable>()
    
    private let repository: CFRepository
    
    init(country: Country, repository: CFRepository = CFWebRepository()) {
        self.country = country
        self.repository = repository
    }
    
    var name: String {
        return country.name ?? "Unknown"
    }
    
    var capital: String? {
        return country.capital
    }
    
    var region: String? {
        switch (country.region, country.subregion) {
        case (.some(let region), let .some(subregion)):     return "\(region) (\(subregion))"
        case (.some(let region), .none):                    return region
        case (.none, .some(let subregion)):                 return "(\(subregion))"
        case (.none, .none):                                return nil
        }
    }
}

extension CountryListRowViewModel {
    func fetchFlag() {
        guard let alpha2Code = country.alpha2Code else { return }
        
        repository.get(id: alpha2Code)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { (completion) in
                switch completion {
                case .finished:
                    break
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
