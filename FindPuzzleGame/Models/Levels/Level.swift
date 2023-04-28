//
//  Level.swift
//  FindPuzzleGame
//
//  Created by Nikita on 16.04.23.
//

import Foundation

class Level {
    var numberOfLevel: Int
    
    var numberOfCards: Int {
        switch numberOfLevel {
        case 1...4:
            return 12
        case 5...9:
            return 20
        case 9...14:
            return 30
        default:
            return 30
        }
       
    }
    
    init(numberOfLevel: Int) {
        self.numberOfLevel = numberOfLevel
    }
}
