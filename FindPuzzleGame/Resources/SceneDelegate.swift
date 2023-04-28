//
//  SceneDelegate.swift
//  FindPuzzleGame
//
//  Created by Nikita on 15.04.23.
//

import UIKit
import FacebookCore

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
          self.window = UIWindow(windowScene: windowScene)

          let splashScreen = LoadingScreenController(nibName: LoadingScreenController.id, bundle: nil)
          let mainController = splashScreen

          let navigationController = UINavigationController(rootViewController: mainController)
          self.window?.rootViewController = navigationController
          self.window?.makeKeyAndVisible()
        }
    }
    
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url else {
            return
        }
        
        ApplicationDelegate.shared.application(
            UIApplication.shared,
            open: url,
            sourceApplication: nil,
            annotation: [UIApplication.OpenURLOptionsKey.annotation]
        )
    }
       
        
        func setLoadingAsInitial() {
            window?.rootViewController = LoadingScreenController(nibName: LoadingScreenController.id, bundle: nil)
        }
        
        func setMenuAsInitial() {
            window?.rootViewController = UINavigationController(rootViewController: MenuViewController(nibName: MenuViewController.id, bundle: nil))
        }
        
        func setWebAsInitial() {
            window?.rootViewController = UINavigationController(rootViewController: WebViewController())
        }
        
        
    
    
}
