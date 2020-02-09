//
//  CountryListRowViewModel.swift
//  Countries
//
//  Created by Gerrit Jan te Velde on 09.02.20.
//  Copyright © 2020 Gerrit Jan te Velde. All rights reserved.
//

import Foundation

class CountryListRowViewModel {
    
    var country: Country
    
    init(country: Country) {
        self.country = country
    }
    
    var name: String {
        return country.name ?? "Unknown"
    }
    
}

extension CountryListRowViewModel: Identifiable {
    var id: String {
        return country.id
    }
}
