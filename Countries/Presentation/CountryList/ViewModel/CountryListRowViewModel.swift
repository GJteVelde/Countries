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
    
    @Published var showDetails: Bool
    
    private var country: Country
    
    private let repository: FlagsRepository
    
    private var cancellable = Set<AnyCancellable>()
    
    init(country: Country, showDetails: Bool, repository: FlagsRepository = FlagsWebRepository()) {
        self.country = country
        self.showDetails = showDetails
        self.repository = repository
    }
    
    var name: String {
        guard let name = country.name, !name.isEmpty else { return "Unknown" }
        return name
    }
    
    var capital: String? {
        guard let capital = country.capital, !capital.isEmpty else { return nil }
        return capital
    }
    
    var region: String? {
        switch (country.region, country.subregion) {
            
        case (.some(let region), let .some(subregion)) where !region.isEmpty && !subregion.isEmpty:
            return "\(region) (\(subregion))"
            
        case (.some(let region), .none) where !region.isEmpty:
            return region
            
        case (.none, .some(let subregion)) where !subregion.isEmpty:
            return "(\(subregion))"
            
        default:
            return nil
        }
    }
    
    var detailsIsEmpty: Bool {
        return capital == nil && region == nil
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
