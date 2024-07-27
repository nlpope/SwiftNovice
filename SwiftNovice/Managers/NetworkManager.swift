//
//  NetworkManager.swift
//  SwiftNovice
//
//  Created by Noah Pope on 7/18/24.
//

import UIKit

class NetworkManager {
    
    static let shared                   = NetworkManager()
    private let baseUrl                 = "http://127.0.0.1:8080/"
    let cache                           = NSCache<NSString, UIImage>()
    
    private init() {}
    
    
    func getPrerequisites(completed: @escaping(Result<[Prerequisite], SNError>) -> Void) {
        
        guard let url = URL(string: "\(baseUrl)getPrerequisites") else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.invalidURL))
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
                var prerequisites = try decoder.decode([Prerequisite].self, from: data)
                completed(.success(prerequisites.sorted { $0.orderId < $1.orderId }))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
    
    func getProjects(completed: @escaping(Result<[Project], SNError>) -> Void) {
        
        guard let url = URL(string: "\(baseUrl)getProjects") else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.invalidURL))
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
                var projects = try decoder.decode([Project].self, from: data)
                completed(.success(projects.sorted { $0.orderId < $1.orderId }))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
    
    func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void) {
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self,
                  error == nil,
                  let response = response as? HTTPURLResponse, response.statusCode == 200,
                  let data = data,
                  let image = UIImage(data: data) else {
                    completed(nil)
                    return
                  }
                    
            self.cache.setObject(image, forKey: cacheKey)
            completed(image)
        }
        
        task.resume()
    }
    
    //    func getPrerequisites(completed: @escaping(Result<[Prerequisite], SNError>) -> Void) {
    //        var prereqArray = [Prerequisite]()
    //        let prereq5 = Prerequisite(courseName: "5 test course name", courseLink: "test course link", price: 500.00, instructor: "Sean Allen", avatarUrl: "https://avatars.githubusercontent.com/u/10645516?v=4", courseBio: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum", orderId: 5)
    //
    //        let prereq1 = Prerequisite(courseName: "1. test course name", courseLink: "test course link", price: 500.00, instructor: "Sean Allen", avatarUrl: "https://comicvine.gamespot.com/a/uploads/square_avatar/0/2/426367-marvel.gif", courseBio: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum", orderId: 1)
    //
    //        prereqArray.append(prereq5)
    //        prereqArray.append(prereq1)
    //        completed(.success(prereqArray))
    //    }
}
