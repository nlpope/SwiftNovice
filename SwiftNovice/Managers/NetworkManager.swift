//
//  NetworkManager.swift
//  SwiftNovice
//
//  Created by Noah Pope on 7/18/24.
//

import UIKit

class NetworkManager {
    
    static let shared       = NetworkManager()
    private let baseUrl     = "http://127.0.0.1:8080/getPrerequisites"
    let cache               = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func getPrerequisites(completed: @escaping(Result<[Prerequisite], SNError>) -> Void) {
        
        guard let url = URL(string: baseUrl) else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let prerequisites = try decoder.decode([Prerequisite].self, from: data)
                completed(.success(prerequisites))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
}
