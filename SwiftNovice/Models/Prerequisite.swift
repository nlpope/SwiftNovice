//
//  Prerequisite.swift
//  SwiftNovice
//
//  Created by Noah Pope on 7/18/24.
//

import Foundation

struct Prerequisite: Codable, Hashable, Comparable {
    static func < (lhs: Prerequisite, rhs: Prerequisite) -> Bool {
        return lhs.courseName < rhs.courseName
    }
    
    let courseName: String
    let courseLink: String
    let price: Double
    let instructor: String
}
