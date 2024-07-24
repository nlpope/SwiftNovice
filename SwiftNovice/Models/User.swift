//
//  User.swift
//  SwiftNovice
//
//  Created by Noah Pope on 7/23/24.
//

import Foundation

struct User: Comparable {
    static func < (lhs: User, rhs: User) -> Bool {
        return lhs.username < rhs.username
    }
    
    let username: String
    let password: String
}
