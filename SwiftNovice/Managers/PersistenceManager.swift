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
    enum Keys { static let accountHolders = "accountHolders" }
}
