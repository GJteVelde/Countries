//
//  ErrorView.swift
//  Countries
//
//  Created by Gerrit Jan te Velde on 27.02.20.
//  Copyright © 2020 Gerrit Jan te Velde. All rights reserved.
//

import SwiftUI

struct ErrorView: View {
    
    let message: String
    let error: Error?
    
    init(message: String, error: Error? = nil) {
        self.message = message
        self.error = error
    }
    
    var body: some View {
        VStack {
            Image(systemName: "xmark.octagon")
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(.red)
            
            Text(message)
            
            error.map({
                Text($0.localizedDescription)
                    .italic()
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            })
        }.padding()
    }
}

struct ErrorView_Previews: PreviewProvider {
    static let testError = URLError(.badURL)
    
    static var previews: some View {
        Group {
            ErrorView(message: "Problem loading countries.", error: testError)
                .previewLayout(.sizeThatFits)
            
            ErrorView(message: "Problem loading countries")
                .previewLayout(.sizeThatFits)
        }
    }
}
