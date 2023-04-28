//
//  FirstViewController.swift
//  FindPuzzleGame
//
//  Created by Nikita on 19.04.23.
//

import Foundation
import UIKit
import SnapKit
import FBSDKCoreKit

class FirstSplashScreenVC: UIViewController {
    var timerObject = Timer()
    let gameViewController = MenuViewController(nibName: MenuViewController.id, bundle: nil)
    let webViewController = WebViewController()
    
    let gameNameLabelImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "emptyFrame")
        return imageView
    }()
    
    let loaderImageViewObject: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage(named: "leprikon")
        return imageView
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        configurateView()
        setConstraints()
        AppEvents.logEvent(.viewedContent)
        
        timerObject = Timer.scheduledTimer(timeInterval: 7.5, target: self, selector: #selector(startLoading), userInfo: nil, repeats: true)
        //timer = Timer.scheduledTimer(timeInterval: 0.0000045, target: self, selector: #selector(startLoading), userInfo: nil, repeats: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func startLoading() {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate

            let internetConnection = appDelegate.internetConnection
            let openVebView = appDelegate.openWebView
            let canContinue = appDelegate.canContinue
            let responseURL = appDelegate.responseURL

            if openVebView == false && canContinue == true {
                AppUtility.lockOrientation(.portrait)
                timerObject.invalidate()
                self.gameViewController.modalPresentationStyle = .fullScreen
                self.gameViewController.navigationItem.hidesBackButton = true
                self.navigationController?.pushViewController(self.gameViewController, animated: false)
            } else if openVebView == true && canContinue == true {
                AppUtility.lockOrientation(.all)
                timerObject.invalidate()
                self.webViewController.responseURL = responseURL ?? "white page"
                self.webViewController.modalPresentationStyle = .fullScreen
                self.webViewController.navigationItem.hidesBackButton = true
                self.navigationController?.pushViewController(self.webViewController, animated: true)
            }
    }
    
    func configurateView() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "firstBack")
        backgroundImage.contentMode = .scaleToFill
        view.insertSubview(backgroundImage, at: 0)
    }
   
    func setConstraints() {
        view.addSubview(loaderImageViewObject)
        loaderImageViewObject.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(view.snp.centerY)
            make.height.equalTo(540)
            make.width.equalTo(400)
        }
        
        view.addSubview(gameNameLabelImage)
        gameNameLabelImage.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-150)
            make.centerX.equalTo(view.snp.centerX)
            make.height.equalTo(100)
            make.width.equalTo(350)
        }
    }
}

