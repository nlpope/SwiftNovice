//  File: NetworkManager.swift
//  Project: SwiftNovice
//  Created by: Noah Pope on 7/18/24.

import UIKit

class NetworkManager
{
    static let shared = NetworkManager()
    private let baseUrl = "http://127.0.0.1:8080/"
    let cache = NSCache<NSString, UIImage>()
    
    
    private init() {}
    
    
//    func fetchCourses(completed: @escaping(Result<[SNCourse], SNError>) -> Void)
//    {
//        guard let url = URL(string: "\(baseUrl)getPrerequisites")
//        else { completed(.failure(.invalidURL)); return }
//        
//        let task = URLSession.shared.dataTask(with: url) { data, response, error in
//            if let _ = error { completed(.failure(.invalidURL)); return }
//            
//            guard let response = response as? HTTPURLResponse, response.statusCode == 200
//            else { completed(.failure(.invalidResponse)); return }
//            
//            guard let data else {
//                completed(.failure(.invalidData))
//                return
//            }
//            
//            do {
//                let decoder = JSONDecoder()
//                var prerequisites = try decoder.decode([SNCourseProject].self, from: data)
//                completed(.success(prerequisites.sorted { $0.orderId < $1.orderId }))
//            } catch {
//                completed(.failure(.invalidData))
//            }
//        }
//        
//        task.resume()
//    }
    
    
//    func fetchProjects(completed: @escaping(Result<[SNCourseProject], SNError>) -> Void)
//    {
//        guard let url = URL(string: "\(baseUrl)getProjects") else {
//            completed(.failure(.invalidURL))
//            return
//        }
//        
//        let task = URLSession.shared.dataTask(with: url) { data, response, error in
//            if let _ = error {
//                completed(.failure(.invalidURL))
//                return
//            }
//            
//            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
//                completed(.failure(.invalidResponse))
//                return
//            }
//            
//            guard let data else {
//                completed(.failure(.invalidData))
//                return
//            }
//            
//            do {
//                let decoder = JSONDecoder()
//                var projects = try decoder.decode([SNCourseProject].self, from: data)
//                completed(.success(projects.sorted { $0.orderId < $1.orderId }))
//            } catch {
//                completed(.failure(.invalidData))
//            }
//        }
//        
//        task.resume()
//    }
    
    
    func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void)
    {
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
}
