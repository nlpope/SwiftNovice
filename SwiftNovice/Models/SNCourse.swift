//  File: SNCourse.swift
//  Project: SwiftNovice
//  Created by: Noah Pope on 6/21/25.

import Foundation

struct SNCourse: Codable, Hashable
{
    let title, instructor, bio: String
    let avatarURL: String?
    let index: Int
    var courseProjects: [SNCourseProject]
    var completed: Bool
    

    func hash(into hasher: inout Hasher) { hasher.combine(title) }
}
