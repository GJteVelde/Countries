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

enum APIError: Error {
    case network(description: String)
    case unknown
}

class CountryListViewModel: ObservableObject {
    
    @Published var isLoading = false
    
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
        print("\(#function) called")
        countries.first(where: { $0.id == id })?.showDetails.toggle()
        showsDetails = countries.filter({ $0.showDetails == true }).count > 0
    }

    func hideDetailsForAllCountries() {
        countries.forEach({ $0.showDetails = false })
        showsDetails = false
    }
    
    func fetchAll() {
        isLoading = true
        
        self.repository.getAll()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { (completion) in
                switch completion {
                case .finished:
                    self.isLoading = false
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }) { (countries) in
                self.rcCountries = countries
            }
            .store(in: &self.cancellable)
    }
}
