//  File: SNCourseProject.swift
//  Project: SwiftNovice
//  Created by: Noah Pope on 7/18/24.

import Foundation

struct SNCourseProject: Codable, Hashable
{
    let title, subtitle, skills, link: String
    let index: Int
    var completed: Bool
    
    func hash(into hasher: inout Hasher) { hasher.combine(title) }
}
