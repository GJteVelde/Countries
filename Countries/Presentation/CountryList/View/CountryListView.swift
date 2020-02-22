//
//  CountryListView.swift
//  Countries
//
//  Created by Gerrit Jan te Velde on 09.02.20.
//  Copyright © 2020 Gerrit Jan te Velde. All rights reserved.
//

import SwiftUI

struct CountryListView: View {
    
    @ObservedObject var viewModel: CountryListViewModel
    
    init(viewModel: CountryListViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    loadingView
                } else if viewModel.countries.isEmpty {
                    emptyListView
                } else {
                    listView
                }
            }
        
            .navigationBarTitle("Countries")
        }.onAppear {
            self.viewModel.fetchAll()
        }
    }
}

extension CountryListView {
    
    private var loadingView: some View {
        LoadingView(message: "Countries are being loaded...")
    }
    
    private var emptyListView: some View {
        Text("Looks like there are no countries to show.")
            .foregroundColor(.secondary)
    }
    
    private var listView: some View {
        List {
            ForEach(viewModel.countries) { countryListRowViewModel in
                CountryListRowView(viewModel: countryListRowViewModel)
            }
        }
    }
}

struct CountryListView_Previews: PreviewProvider {
    static var viewModel = CountryListViewModel()
    
    static var previews: some View {
        CountryListView(viewModel: viewModel)
    }
}
