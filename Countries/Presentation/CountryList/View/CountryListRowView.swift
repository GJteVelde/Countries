//
//  CountryListRowView.swift
//  Countries
//
//  Created by Gerrit Jan te Velde on 09.02.20.
//  Copyright © 2020 Gerrit Jan te Velde. All rights reserved.
//

import SwiftUI

struct CountryListRowView: View {
    
    let viewModel: CountryListRowViewModel
    
    init(viewModel: CountryListRowViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack {
            Text(viewModel.name)
            
            Spacer()
        }
    }
}

struct CountryListRowView_Previews: PreviewProvider {
    static var country = Country(alpha3Code: "COL", name: "Colombia")
    static var viewModel = CountryListRowViewModel(country: country)
    
    static var previews: some View {
        CountryListRowView(viewModel: viewModel)
            .previewLayout(.sizeThatFits)
    }
}
