//
//  AnyTransition.swift
//  Countries
//
//  Created by Gerrit Jan te Velde on 26.02.20.
//  Copyright © 2020 Gerrit Jan te Velde. All rights reserved.
//

import SwiftUI

public extension AnyTransition {
    
    ///Inserts the view from the top down and changes the opacity. Removes the view by changing the opacity and moving to the top.
    static var moveAndFade: AnyTransition {
        let insertion = AnyTransition.move(edge: .top).combined(with: .opacity)
        let removal = AnyTransition.move(edge: .top).combined(with: .opacity)
        return .asymmetric(insertion: insertion, removal: removal)
    }
}
