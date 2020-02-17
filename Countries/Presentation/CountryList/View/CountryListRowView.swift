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
            FlagImage(flag: viewModel.$flag, code: viewModel.id)
                .frame(width: 50, height: 50)
            
            Text(viewModel.name)
            
            Spacer()
        }
    }
}

struct CountryListRowView_Previews: PreviewProvider {
    static var country = Country(alpha3Code: "NLD", name: "Netherlands")
    static var viewModel = CountryListRowViewModel(country: country)
    
    static var previews: some View {
        Group {
            CountryListRowView(viewModel: viewModel)
                .previewLayout(.sizeThatFits)
        }
    }
}
