//
//  LoadingView.swift
//  Countries
//
//  Created by Gerrit Jan te Velde on 22.02.20.
//  Copyright © 2020 Gerrit Jan te Velde. All rights reserved.
//

import SwiftUI

struct LoadingView: View {
    
    var message: String?
    
    @State private var spin = false
    
    var body: some View {
        VStack {
            
            message.map {
                Text($0)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
            
            Image(systemName: "arrow.2.circlepath.circle")
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundColor(.secondary)
                .rotationEffect(.degrees(spin ? 180 : 0))
                .animation(
                    Animation
                        .spring(response: 0.5, dampingFraction: 1, blendDuration: 0.1)
                        .repeatForever(autoreverses: false)
                )
                .onAppear {
                    self.spin.toggle()
                }
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LoadingView(message: "Countries are being loaded...")
                .previewLayout(.sizeThatFits)
        }
    }
}
