//
//  CardModel.swift
//  FindPuzzleGame
//
//  Created by Nikita on 16.04.23.
//

import Foundation

class CardModel {
    
    func getCards(_ number: Int) -> [Card] {
        var generatedCardsArray = [Card]()
        
        for _ in 1...number/2 {
            let randomNumber = arc4random_uniform(13) + 1
            let cardOne = Card(imageName: "card\(randomNumber)", isFlipped: false, isMatched: false)
            generatedCardsArray.append(cardOne)
            
            let cardTwo =  Card(imageName: "card\(randomNumber)", isFlipped: false, isMatched: false)
            generatedCardsArray.append(cardTwo)
        }
        
        generatedCardsArray.shuffle()
        
        return generatedCardsArray
    }
}
