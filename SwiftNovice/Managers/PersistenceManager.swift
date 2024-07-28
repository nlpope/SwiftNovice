//
//  PersistenceManager.swift
//  SwiftNovice
//
//  Created by Noah Pope on 7/20/24.
//

import Foundation

enum ProgressPersistenceActionType {
    case complete, incomplete
}

enum PersistenceManager {
    
    static private let defaults = UserDefaults.standard
    enum Keys {
        static let accountHolders                   = "accountHolders"
        static let isLoggedIn                       = "isLoggedIn"
        static let completedCourses                 = "completedCourses"
        static let completedProjects                = "completedProjects"
        static var isFirstVisitToPrerequisiteScreen = true
        static var isFirstVisitToProjectScreen      = true
    }
    
    
    // MARK: COURSE PERSISTENCE
    static func updateWith(course: Prerequisite, actionType: ProgressPersistenceActionType, completed: @escaping (SNError?) -> Void) {
        retrieveCompletedCourses { result in
            switch result {
            case .success(var courses):
                switch actionType {
                case .complete:
                    courses.append(course)
                    
                case .incomplete:
                    courses.removeAll { $0.courseName == course.courseName }
                }
                completed(save(completedCourses: courses))
                
            case .failure(let error):
                completed(error)
            }
        }
    }  
    
    
    static func updateWith(project: Project, actionType: ProgressPersistenceActionType, completed: @escaping (SNError?) -> Void) {
        retrieveCompletedProjects { result in
            switch result {
            case .success(var projects):
                switch actionType {
                case .complete:
                    projects.append(project)
                    
                case .incomplete:
                    projects.removeAll { $0.projectName == project.projectName }
                }
                completed(save(completedProjects: projects))
                
            case .failure(let error):
                completed(error)
            }
        }
    }
    
    
    static func updateLoggedInStatus(loggedIn: Bool) {
        guard loggedIn else {
            defaults.set(false, forKey: Keys.isLoggedIn)
            return
        }
        defaults.set(true, forKey: Keys.isLoggedIn)
        return
    }
    
    
    static func retrieveCompletedCourses(completed: @escaping (Result<[Prerequisite], SNError>) -> Void) {
        guard let completedCoursesData = defaults.object(forKey: Keys.completedCourses) as? Data else {
            completed(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let completedCourses = try decoder.decode([Prerequisite].self, from: completedCoursesData)
            completed(.success(completedCourses))
        } catch {
            completed(.failure(.failedToLoadProgress))
        }
    }
    
    
    static func retrieveCompletedProjects(completed: @escaping (Result<[Project], SNError>) -> Void) {
        guard let completedProjectsData = defaults.object(forKey: Keys.completedProjects) as? Data else {
            completed(.success([]))
            return
        }
        
        do {
            let decoder             = JSONDecoder()
            let completedProjects   = try decoder.decode([Project].self, from: completedProjectsData)
            completed(.success(completedProjects))
        } catch {
            completed(.failure(.failedToLoadProgress))
        }
    }
    
    
    static func save(completedCourses: [Prerequisite]) -> SNError? {
        do {
            let encoder = JSONEncoder()
            let encodedCompletedCourses = try encoder.encode(completedCourses)
            defaults.setValue(encodedCompletedCourses, forKey: Keys.completedCourses)
            return nil
        } catch {
            return .failedToSaveProgress
        }
    } 
    
    
    static func save(completedProjects: [Project]) -> SNError? {
        do {
            let encoder = JSONEncoder()
            let encodedCompletedProjects = try encoder.encode(completedProjects)
            defaults.setValue(encodedCompletedProjects, forKey: Keys.completedProjects)
            return nil
        } catch {
            return .failedToSaveProgress
        }
    }
    
    
    // MARK: LOGIN PERSISTENCE
    static func retrieveLoggedInStatus() -> Bool {
        let loggedInStatus = defaults.bool(forKey: Keys.isLoggedIn)
        guard loggedInStatus else { return false }
        return true
    }
}
