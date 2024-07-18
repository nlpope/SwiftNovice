//
//  NetworkManager.swift
//  SwiftNovice
//
//  Created by Noah Pope on 7/18/24.
//

import UIKit

class NetworkManager {
    
    static let shared       = NetworkManager()
    private let baseURL     = ""
    let cache               = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func getAllPrereqs(completed: @escaping(Result<[Prerequisite], SNError>) -> Void) {
        
    }
}
