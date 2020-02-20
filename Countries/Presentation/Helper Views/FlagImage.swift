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
            Group {
                if self.flag == nil {
                    ZStack {
                        Circle()
                            .fill(Color.gray)
                            .overlay(Circle().strokeBorder(Color.white, lineWidth: self.minSize(geometry.size) * 0.02))
                            .shadow(radius: self.minSize(geometry.size) * 0.04)
                        
                        Text(self.code.uppercased())
                            .foregroundColor(.secondary)
                            .font(.system(size: self.minSize(geometry.size) * 0.4, weight: .heavy, design: .monospaced))
                    }
                        .transition(AnyTransition.opacity.animation(.easeInOut(duration: 1.0)))
                } else {
                    self.flag!
                        .resizable(resizingMode: .stretch)
                        .background(Color.secondary)
                        .clipShape(Circle())
                        .overlay(Circle().strokeBorder(Color.white, lineWidth: self.minSize(geometry.size) * 0.02))
                        .shadow(radius: self.minSize(geometry.size) * 0.04)
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
                .previewLayout(.fixed(width: 400, height: 400))
                .previewDisplayName("Square. Image.")
            
            FlagImage(code: "nld", flag: .constant(nil))
                .previewLayout(.fixed(width: 200, height: 400))
                .previewDisplayName("Rectangle. No Image.")
            
            FlagImage(code: "nld", flag: .constant(nil))
                .previewLayout(.fixed(width: 400, height: 200))
                .environment(\.colorScheme, .dark)
            .previewDisplayName("Rectangle. No Image. Dark Mode.")
        }
    }
}
