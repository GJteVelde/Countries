//
//  FlagImage.swift
//  Countries
//
//  Created by Gerrit Jan te Velde on 20.02.20.
//  Copyright © 2020 Gerrit Jan te Velde. All rights reserved.
//

import SwiftUI

struct FlagImage: View {
    
    let code: String
    @Binding var flag: Image?
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Circle()
                    .fill(Color.secondary)
                    .overlay(Circle().strokeBorder(Color.primary, lineWidth: self.minSize(geometry.size) * 0.02))
                    .shadow(radius: self.minSize(geometry.size) * 0.04)
                
                if self.flag == nil {
                    Text(self.code.uppercased())
                        .foregroundColor(.primary)
                        .font(.system(size: self.minSize(geometry.size) * 0.4, weight: .heavy, design: .monospaced))
                        .transition(AnyTransition.opacity.animation(.easeInOut(duration: 1.0)))
                } else {
                    self.flag!
                        .resizable(resizingMode: .stretch)
                        .clipShape(Circle())
                        .frame(width: geometry.size.width * 0.96, height: geometry.size.height * 0.96)
                        .transition(AnyTransition.opacity.animation(.easeInOut(duration: 1.0)))
                }
            }
        }
    }
    
    private func minSize(_ size: CGSize) -> CGFloat {
        return min(size.width, size.height)
    }
}

struct FlagImage_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FlagImage(code: "nld", flag: .constant(Image("nld")))
                .previewLayout(.fixed(width: 200, height: 200))
            
            FlagImage(code: "nld", flag: .constant(Image("nld")))
                .previewLayout(.fixed(width: 200, height: 200))
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Dark Mode.")
            
            FlagImage(code: "nld", flag: .constant(nil))
                .previewLayout(.fixed(width: 100, height: 200))
            
            FlagImage(code: "nld", flag: .constant(nil))
                .previewLayout(.fixed(width: 200, height: 100))
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Dark Mode.")
        }
    }
}
