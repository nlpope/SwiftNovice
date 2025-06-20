//
//  Project.swift
//  SwiftNovice
//
//  Created by Noah Pope on 7/26/24.
//

import Foundation

struct Project: Codable, Comparable
{
    let projectName: String
    let projectLink: String
    let avatarUrl: String
    let projectBio: String
    let orderId: Int
    
    
    static func < (lhs: Project, rhs: Project) -> Bool
    {
        return lhs.projectName < rhs.projectName
    }
}
