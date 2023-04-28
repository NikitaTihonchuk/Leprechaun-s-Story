//
//  SetupSceneDelegate.swift
//  FindPuzzleGame
//
//  Created by Nikita on 15.04.23.
//

import Foundation
import UIKit
///для взаимодействия с методами sceneDelegate
struct SetupSceneDelegate {
    static var sceneDelegate: SceneDelegate? {
        let scene = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
        return scene
    }
}
