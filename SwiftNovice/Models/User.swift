//  File: User.swift
//  Project: SwiftNovice
//  Created by: Noah Pope on 7/23/24.

import Foundation

struct User: Comparable
{
    let username: String
    let password: String
    
    
    static func < (lhs: User, rhs: User) -> Bool { return lhs.username < rhs.username }
}
