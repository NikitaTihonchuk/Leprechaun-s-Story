//
//  MenuViewController.swift
//  FindPuzzleGame
//
//  Created by Nikita on 15.04.23.
//

import UIKit

class MenuViewController: UIViewController {
    static let id = String(describing: MenuViewController.self)
    
    @IBOutlet weak var menuLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var rulesButton: UIButton!
    @IBOutlet weak var levelButton: UIButton!
    @IBOutlet weak var policyButton: UIButton!
    @IBOutlet weak var exitButton: UIButton!
    
    private var meriendaFont = UIFont(name: "MeriendaOne-Regular", size: 45)

    private var userLevel = DefaultsManager.levelCompleted
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAttributedString()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        userLevel = DefaultsManager.levelCompleted
    }
    
    private func setAttributedString() {
        menuLabel.font = meriendaFont
        let strokeTextAttributes: [NSAttributedString.Key: Any] = [
            .strokeColor: UIColor().hexStringToUIColor(hex:"511834"),
            .foregroundColor: UIColor().hexStringToUIColor(hex: "FFFFFF"),
            .strokeWidth: -3
        ]
        let text = "MENU"
        menuLabel.attributedText = NSAttributedString(string: text, attributes: strokeTextAttributes)
    }
    
    
    @IBAction func playButtonDidTap(_ sender: UIButton) {
        playButton.alpha = 0.5
        let vc = SelectLevelController(nibName: SelectLevelController.id, bundle: nil)
        navigationController?.pushViewController(vc, animated: true)
        _ = Timer.scheduledTimer(withTimeInterval: 0.15, repeats: false) { _ in
            self.playButton.alpha = 1
        }
    }
    
    
    @IBAction func rulesButtonDidTap(_ sender: UIButton) {
        rulesButton.alpha = 0.5
        let vc = RulesViewController(nibName: RulesViewController.id, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
        _ = Timer.scheduledTimer(withTimeInterval: 0.15, repeats: false) { _ in
            self.rulesButton.alpha = 1
        }
    }
    
    
    @IBAction func policyButtonDidTap(_ sender: UIButton) {
        let vc = PolicyWV()
        vc.responseURL = "https://telegra.ph/Leprechauns-Story-04-18"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func exitButtonDidTap(_ sender: UIButton) {
        exitButton.alpha = 0.5
        UIControl().sendAction(#selector(NSXPCConnection.suspend), to: UIApplication.shared, for: nil)
        _ = Timer.scheduledTimer(withTimeInterval: 0.15, repeats: false) { _ in
            self.exitButton.alpha = 1
        }
    }
    


   
}
