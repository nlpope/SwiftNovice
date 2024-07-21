//
//  PersistenceManager.swift
//  SwiftNovice
//
//  Created by Noah Pope on 7/20/24.
//

import Foundation

enum PersistenceActionType {
    case add, remove
}

enum PersistenceManager {
    
    static private let defaults = UserDefaults.standard
    enum Keys {
        static let accountHolders   = "accountHolders"
        static let isLoggedIn       = "isLoggedIn"
    }
    
    
    static func updateLoggedInStatus(loggedIn: Bool) {
        guard loggedIn else {
            defaults.set(false, forKey: Keys.isLoggedIn)
            return
        }
        defaults.set(true, forKey: Keys.isLoggedIn)
        return
    }
    
    
    static func retrieveLoggedInStatus() -> Bool {
        let loggedInStatus = defaults.bool(forKey: Keys.isLoggedIn)
        guard loggedInStatus else { return false }
        return true
    }
}
