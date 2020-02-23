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
        }
        .frame(minWidth: 50, maxWidth: .infinity, alignment: .topLeading)
        .onTapGesture {
            self.viewModel.showDetails.toggle()
        }
        .onAppear {
            self.viewModel.fetchFlag()
        }
    }
    
    var detailsView: some View {
        VStack {
            viewModel.capital.map {     DetailRow(name: "Capital", content: $0) }
            viewModel.region.map {      DetailRow(name: "Region", content: $0) }
        }
    }
}

private extension CountryListRowView {
    struct DetailRow: View {
        var name: String
        var content: String
    
        var body: some View {
            HStack {
                Text(name)
                    .font(.footnote)
                
                Spacer()
                
                Text(content)
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
        }
    }
}

fileprivate extension AnyTransition {
    static var moveAndFade: AnyTransition {
        let insertion = AnyTransition.move(edge: .top).combined(with: .opacity)
        let removal = AnyTransition.move(edge: .top).combined(with: .opacity)
        return .asymmetric(insertion: insertion, removal: removal)
    }
}

struct CountryListRowView_Previews: PreviewProvider {
    static var country = Country(alpha3Code: "NLD", alpha2Code: "NL", name: "The Netherlands", capital: "Amsterdam", region: "Europe", subregion: "Western Europe")
    static var viewModel: CountryListRowViewModel = {
        let v = CountryListRowViewModel(country: country)
        v.showDetails = true
        return v
    }()
    
    static var previews: some View {
        CountryListRowView(viewModel: viewModel)
            .previewLayout(.fixed(width: 300, height: 100))
    }
}
