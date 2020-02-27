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
    
    @Binding var isSelected: Bool
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Circle()
                    .fill(Color(white: 0.5))
                    .overlay(Circle().strokeBorder(Color.white, lineWidth: self.minSize(geometry.size) * 0.02))
                    .shadow(radius: self.minSize(geometry.size) * 0.04)
                    .zIndex(0)
                
                if self.flag == nil {
                    Text(self.code.uppercased())
                        .foregroundColor(Color(white: 0.7))
                        .font(.system(size: self.minSize(geometry.size) * 0.4, weight: .heavy, design: .monospaced))
                        .transition(AnyTransition.opacity.animation(.easeInOut))
                        .zIndex(1)
                } else {
                    self.flag!
                        .resizable()
                        .clipShape(Circle())
                        .frame(width: geometry.size.width * 0.96, height: geometry.size.height * 0.96)
                        .transition(AnyTransition.opacity.animation(.easeInOut))
                        .zIndex(2)
                }
                
                Image(systemName: "arrowtriangle.right.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: self.minSize(geometry.size) * 0.5, height: self.minSize(geometry.size) * 0.5)
                    .foregroundColor(.white)
                    .background(
                        Color.black
                            .clipShape(Circle())
                            .opacity(0.5)
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .overlay(Circle().strokeBorder(Color.white, lineWidth: self.minSize(geometry.size) * 0.02))
                    )
                    .opacity(self.isSelected ? 1 : 0)
                    .rotationEffect(.degrees(self.isSelected ? 90 : 0))
                    .animation(.easeInOut)
                    .zIndex(3)
            }
        }
    }
    
    private func minSize(_ size: CGSize) -> CGFloat {
        return min(size.width, size.height)
    }
}

struct FlagImage_Previews: PreviewProvider {
    
    static var isSelected: Bool = true
    
    static var previews: some View {
        Group {
            FlagImage(code: "nld", flag: .constant(Image("nld")), isSelected: .constant(isSelected))
                .previewLayout(.fixed(width: 200, height: 200))
            
            FlagImage(code: "nld", flag: .constant(Image("nld")), isSelected: .constant(isSelected))
                .previewLayout(.fixed(width: 200, height: 200))
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Dark Mode.")
            
            FlagImage(code: "nld", flag: .constant(nil), isSelected: .constant(isSelected))
                .previewLayout(.fixed(width: 100, height: 200))
            
            FlagImage(code: "nld", flag: .constant(nil), isSelected: .constant(isSelected))
                .previewLayout(.fixed(width: 200, height: 100))
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Dark Mode.")
        }
    }
}
