//
//  Card.swift
//  FindPuzzleGame
//
//  Created by Nikita on 16.04.23.
//

import Foundation

class Card {
    var imageName: String
    var isFlipped: Bool
    var isMatched: Bool
    
    init(imageName: String, isFlipped: Bool, isMatched: Bool) {
        self.imageName = imageName
        self.isFlipped = isFlipped
        self.isMatched = isMatched
    }
}
