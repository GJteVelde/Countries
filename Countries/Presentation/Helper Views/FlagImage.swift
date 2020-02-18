//
//  FlagImage.swift
//  Countries
//
//  Created by Gerrit Jan te Velde on 16.02.20.
//  Copyright © 2020 Gerrit Jan te Velde. All rights reserved.
//

import SwiftUI

struct FlagImage: View {
    
    var flag: Image?
    let code: String
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                if self.flag != nil {
                    self.flagImage(flag: self.flag!, size: geometry.size)
                } else {
                    self.circleBackground(size: geometry.size)
                    self.codeText(size: geometry.size)
                }
            }
        }
    }
}

extension FlagImage {
    
    private func circleBackground(size: CGSize) -> some View {
        let minSize = min(size.width, size.height)
        
        return Circle()
            .fill(Color.gray)
            .overlay(
                Circle().strokeBorder(Color.white, lineWidth: minSize * 0.02)
            )
            .shadow(radius: minSize * 0.04)
            .frame(width: minSize, height: minSize)
    }
    
    private func flagImage(flag: Image, size: CGSize) -> some View {
        let minSize = min(size.width, size.height)
        
        return flag
            .resizable()
            .aspectRatio(contentMode: .fill)
            .clipShape(Circle())
            .overlay(
                Circle().strokeBorder(Color.white, lineWidth: minSize * 0.02)
            )
            .shadow(radius: minSize * 0.04)
            .frame(width: minSize, height: minSize)
    }
    
    private func codeText(size: CGSize) -> some View {
        let minSize = min(size.width, size.height)
        
        return Text(code.uppercased())
            .foregroundColor(.secondary)
            .font(.system(size: minSize * 0.4, weight: .heavy, design: .monospaced))
    }
}

struct FlagImage_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            FlagImage(flag: Image("nld"), code: "nld")
                .previewLayout(.fixed(width: 400, height: 400))
            
            FlagImage(flag: nil, code: "nld")
                .previewLayout(.fixed(width: 200, height: 400))
                .previewDisplayName("Rectangle. No image.")
            
            FlagImage(flag: nil, code: "nld")
                .previewLayout(.fixed(width: 400, height: 200))
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Rectangle. No image. DarkMode.")
        }
    }
}
