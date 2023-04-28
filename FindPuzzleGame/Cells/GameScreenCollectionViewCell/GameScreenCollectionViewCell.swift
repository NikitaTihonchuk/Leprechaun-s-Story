//
//  GameScreenCollectionViewCell.swift
//  FindPuzzleGame
//
//  Created by Nikita on 16.04.23.
//

import UIKit

class GameScreenCollectionViewCell: UICollectionViewCell {
    static let id = String(describing: GameScreenCollectionViewCell.self)

    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var backImageView: UIImageView!
    
    var card: Card?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func set(model: Card) {
        self.card = model
        
        cardImageView.image = UIImage(named: model.imageName)
        
        if model.isMatched == true {
            backImageView.alpha = 0
            cardImageView.alpha = 0
            return
        }
        else {
            backImageView.alpha = 1
            cardImageView.alpha = 1
        }
    }
    
    func flipUp(speed:TimeInterval = 0.3) {
        
        UIView.transition(from: backImageView, to: cardImageView, duration: speed, options: [.showHideTransitionViews,.transitionFlipFromLeft], completion: nil)
        
        card?.isFlipped = true
    }
   
    func flipDown(speed:TimeInterval = 0.3, delay:TimeInterval = 0.5) {
        
        card?.isFlipped = false
        
        ///сделал диспатч DispatchQueue того, чтобы пользователь мог пол секунды взглянуть на карту
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay) {
            UIView.transition(from: self.cardImageView, to: self.backImageView, duration: speed, options: [.showHideTransitionViews, .transitionFlipFromLeft], completion: nil)
        }
    }
    
    func remove() {
        
        backImageView.alpha = 0
        
        UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveEaseOut, animations: {
            
            self.cardImageView.alpha = 0
            
        }, completion: nil)
    }

}
