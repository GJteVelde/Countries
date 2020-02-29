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
            
            content
                
            .navigationBarTitle("Countries")
            .navigationBarItems(trailing: collapseButton)
        }.onAppear {
            self.viewModel.fetchAll()
        }
    }
}

extension CountryListView {
    
    private var content: some View {
        switch viewModel.state {
        case .start:
            return AnyView(Text("Hey, what's up?"))
            
        case .loading:
            return AnyView(LoadingView(message: "Countries are being loaded..."))
            
        case .results:
            return viewModel.countries.isEmpty ? AnyView(emptyListView) : AnyView(listView)
            
        case .error(let error):
            return AnyView(ErrorView(message: "Problem loading countries.", error: error))
        }
    }
    
    private var emptyListView: some View {
        Text("Looks like there are no countries to show.")
            .foregroundColor(.secondary)
    }
    
    private var listView: some View {
        ScrollView {
            ForEach(viewModel.countries) { (vm) in
                CountryListRowView(viewModel: vm)
                    .modifier(ListRowModifier())
                    .animation(.easeInOut)
                    .onTapGesture {
                        self.viewModel.selectDeselect(vm.id)
                    }
            }.padding()
        }
    }
    
    private var collapseButton: some View {
        
        Button(action: {
            self.viewModel.hideDetailsForAllCountries()
        }, label: {
            Image(systemName: "arrowtriangle.right.fill")
                .contentShape(Rectangle())
                .frame(width: 40, height: 40)
                .rotationEffect(.degrees(viewModel.showsDetails ? 90 : 0))
                .scaleEffect(viewModel.showsDetails ? 1.8 : 1)
                .animation(.easeInOut)
        }).disabled(!viewModel.showsDetails)
    }
}

struct ListRowModifier: ViewModifier {
    func body(content: Content) -> some View {
        Group {
            content
            Divider()
        }
    }
}

struct CountryListView_Previews: PreviewProvider {
    static var viewModel = CountryListViewModel()
    
    static var previews: some View {
        CountryListView(viewModel: viewModel)
    }
}
