//
//  CountryList.swift
//  Countries
//
//  Created by Gerrit Jan te Velde on 09.02.20.
//  Copyright © 2020 Gerrit Jan te Velde. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class CountryListViewModel: ObservableObject {
    
    @Published var state = StateMachine.State.start
    
    @Published var countries = [CountryListRowViewModel]()
    
    @Published var showsDetails: Bool = false
    
    private var rcCountries = [Country]() {
        didSet {
            rcCountries.forEach { (country) in
                self.countries.append(CountryListRowViewModel(country: country, showDetails: false))
            }
        }
    }
    
    private var cancellable = Set<AnyCancellable>()
    
    private let repository: CountriesRepository
    
    init(repository: CountriesRepository = CountriesWebRepository()) {
        self.repository = repository
    }
}

extension CountryListViewModel {

    func selectDeselect(_ id: String) {
        countries.first(where: { $0.id == id })?.showDetails.toggle()
        showsDetails = countries.filter({ $0.showDetails == true }).count > 0
    }

    func hideDetailsForAllCountries() {
        countries.forEach({ $0.showDetails = false })
        showsDetails = false
    }
    
    func fetchAll() {
        state = .loading
        
        self.repository.getAll()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { (completion) in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.state = .error(error)
                }
            }) { (countries) in
                self.rcCountries = countries
                self.state = .results
            }
            .store(in: &self.cancellable)
    }
}
