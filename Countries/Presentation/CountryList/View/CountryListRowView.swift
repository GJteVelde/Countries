//
//  CountryListRowView.swift
//  Countries
//
//  Created by Gerrit Jan te Velde on 09.02.20.
//  Copyright © 2020 Gerrit Jan te Velde. All rights reserved.
//

import SwiftUI

struct CountryListRowView: View {
    
    @ObservedObject var viewModel: CountryListRowViewModel
    
    init(viewModel: CountryListRowViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack(alignment: .top) {
            FlagImage(code: viewModel.id, flag: $viewModel.flag, isSelected: $viewModel.showDetails)
                .frame(width: 50, height: 50)
            
            VStack(alignment: .leading) {
                Text(viewModel.name)
                    .frame(height: 50)
                
                if viewModel.showDetails {
                    detailsView
                        .transition(.moveAndFade)
                }
            }
            
            Spacer()
        }
        .contentShape(Rectangle())
        .frame(minWidth: 50, maxWidth: .infinity, alignment: .topLeading)
        .onAppear {
            self.viewModel.fetchFlag()
        }
    }
    
    var detailsView: some View {
        VStack {
            viewModel.capital.map {     DetailRow(name: "Capital", content: $0) }
            viewModel.region.map {      DetailRow(name: "Region", content: $0) }
            
            if viewModel.detailsIsEmpty {
                DetailRow(name: "No details available.", content: "")
            }
        }
    }
}

private extension CountryListRowView {
    struct DetailRow: View {
        var name: String?
        var content: String
    
        var body: some View {
            HStack {
                if name != nil {
                    Text(name!)
                        .font(.footnote)
                }
                
                Spacer()
                
                Text(content)
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
        }
    }
}

struct CountryListRowView_Previews: PreviewProvider {
    static var netherlandsVM = CountryListRowViewModel(country: Country.Netherlands, showDetails: true)
    static var antarcticaVM = CountryListRowViewModel(country: Country.Antarctica, showDetails: true)

    static var previews: some View {
        Group {
            CountryListRowView(viewModel: netherlandsVM)
            
            CountryListRowView(viewModel: antarcticaVM)
        }
    }
}
