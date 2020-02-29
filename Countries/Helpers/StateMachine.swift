//
//  StateMachine.swift
//  Countries
//
//  Created by Gerrit Jan te Velde on 27.02.20.
//  Copyright © 2020 Gerrit Jan te Velde. All rights reserved.
//

import Foundation

class StateMachine {
    
    enum State {
        case start
        case loading
        case results
        case error(_ error: Error? = nil)
    }
    
}
