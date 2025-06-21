//  File: SNCourse.swift
//  Project: SwiftNovice
//  Created by: Noah Pope on 6/21/25.

import Foundation

struct SNCourse: Codable, Hashable
{
    let title, instructor, avatarURL, bio: String
    let index: Int
    let courseProjects: [SNCourseProject]
    

    func hash(into hasher: inout Hasher) { hasher.combine(title) }
}
