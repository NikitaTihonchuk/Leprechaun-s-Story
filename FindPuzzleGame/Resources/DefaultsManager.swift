//
//  DefaultsManager.swift
//  FindPuzzleGame
//
//  Created by Nikita on 16.04.23.
//

import Foundation

class DefaultsManager {
    private static let defaults = UserDefaults.standard
    
    static var levelCompleted: Int? {
        get {
            defaults.value(forKey: #function) as? Int
        }
        set {
            defaults.set(newValue, forKey: #function)
        }
    }
    
    
    static func load() {
        if levelCompleted == nil {
            levelCompleted = 1
        }
    }
    
    
}
