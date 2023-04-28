//
//  RulesViewController.swift
//  FindPuzzleGame
//
//  Created by Nikita on 18.04.23.
//

import UIKit

class RulesViewController: UIViewController {
    static let id = String(describing: RulesViewController.self)
    
    @IBOutlet weak var rulesTextLabel: UILabel!
    @IBOutlet weak var rulesLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    private var meriendaFont = UIFont(name: "MeriendaOne-Regular", size: 40)

    override func viewDidLoad() {
        super.viewDidLoad()
        setAttributedStringToHeader()
        setAttributedStringToRules()
        // Do any additional setup after loading the view.
    }
    
    private func setAttributedStringToHeader() {
        rulesTextLabel.font = meriendaFont
        let strokeTextAttributes: [NSAttributedString.Key: Any] = [
            .strokeColor: UIColor().hexStringToUIColor(hex:"511834"),
            .foregroundColor: UIColor().hexStringToUIColor(hex: "FFFFFF"),
            .strokeWidth: -3
        ]
        let text = "RULES"
        rulesTextLabel.attributedText = NSAttributedString(string: text, attributes: strokeTextAttributes)
    }
    
    private func setAttributedStringToRules() {
        rulesLabel.font = meriendaFont?.withSize(20)
        let strokeTextAttributes: [NSAttributedString.Key: Any] = [
            .strokeColor: UIColor().hexStringToUIColor(hex:"511834"),
            .foregroundColor: UIColor().hexStringToUIColor(hex: "FFFFFF"),
            .strokeWidth: -3
        ]
        let text = "THIS IS A SIMPLE CARD GAME WHERE ALL THE CARDS ARE PLACED FACE DOWN, AND ON EACH TURN, TWO CARDS ARE FLIPPED FACE UP. THE OBJECTIVE OF THE GAME IS TO FIND AND MATCH PAIRS OF IDENTICAL CARDS. THE MORE PAIRS YOU MATCH, THE HIGHER YOUR SCORE. ADDITIONALLY, COLLECTING COINS DURING THE GAME CAN ALSO BOOST YOUR SCORE."
        rulesLabel.attributedText = NSAttributedString(string: text, attributes: strokeTextAttributes)
    }
    
    
    @IBAction func closeButton(_ sender: UIButton) {
        closeButton.alpha = 0.5
        
        dismiss(animated: true)
        
        _ = Timer.scheduledTimer(withTimeInterval: 0.15, repeats: false) { _ in
            self.closeButton.alpha = 1
        }
    }
    

}

