//
//  LoadingScreenController.swift
//  FindPuzzleGame
//
//  Created by Nikita on 15.04.23.
//

import UIKit
import AppsFlyerLib

class LoadingScreenController: UIViewController {
    static let id = String(describing: LoadingScreenController.self)

    @IBOutlet weak var loadingLabel: UILabel!
    private var timer: Timer? = nil
    private var timerObject = Timer()
    private var dotCount = 3
    private let meriendaFont = UIFont(name: "MeriendaOne-Regular", size: 22)
    let appsFlyerUID = AppsFlyerLib.shared().getAppsFlyerUID()
    let gameViewController = MenuViewController(nibName: MenuViewController.id, bundle: nil)
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        DefaultsManager.load()
        makeStrokeLoadingLabel()
        timerObject = Timer.scheduledTimer(timeInterval: 7.5, target: self, selector: #selector(startLoading), userInfo: nil, repeats: true)
    }
    
    @objc func startLoading() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate

        let internetConnect = appDelegate.internetConnection
        let openWebView = appDelegate.openWebView
        let canContinue = appDelegate.canContinue
        let responseURL = appDelegate.responseURL

        if openWebView == false && canContinue == true {
            AppUtility.lockOrientation(.portrait)
            timerObject.invalidate()
            self.gameViewController.modalPresentationStyle = .fullScreen
            self.gameViewController.navigationItem.hidesBackButton = true
            self.navigationController?.pushViewController(self.gameViewController, animated: true)
        } else if openWebView == true && canContinue == true {
            AppUtility.lockOrientation(.all)
            timerObject.invalidate()
            
            let vc = WebViewController()
            vc.responseURL = responseURL ?? "white page"
            vc.navigationItem.hidesBackButton = true
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
 
    
    @objc func updateButtonTitle() {
        dotCount += 1
        if dotCount > 3 {
            dotCount = 1
        }
        let dots = String(repeating: ".", count: dotCount)
        loadingLabel.text = "LOADING\(dots)"
        
    }
    
    private func makeStrokeLoadingLabel() {
        let strokeTextAttributes: [NSAttributedString.Key: Any] = [
            .strokeColor: UIColor().hexStringToUIColor(hex: "413107"),
            .foregroundColor: UIColor.white,
            .strokeWidth: -4.5
        ]
        let text = NSAttributedString(string: "LOADING...", attributes: strokeTextAttributes)
        loadingLabel.font = meriendaFont
        loadingLabel.attributedText = text
        let _ = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(updateButtonTitle), userInfo: nil, repeats: true)
    }
    
    
    

   

}
