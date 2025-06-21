//  File: PersistenceManager.swift
//  Project: SwiftNovice
//  Created by: Noah Pope on 7/20/24.

import Foundation

enum ProgressPersistenceActionType
{
    case complete, incomplete
}

enum PersistenceManager
{
    static private let defaults = UserDefaults.standard
    
    static var isVeryFirstVisit: Bool! = fetchVeryFirstVisitStatus() {
        didSet { PersistenceManager.saveVeryFirstVisit(status: isVeryFirstVisit) }
    }
    
    static var isFirstVisitAfterDismissal: Bool! = fetchFirstVisitPostDismissalStatus() {
        didSet { PersistenceManager.saveFirstVisitPostDismissal(status: isFirstVisitAfterDismissal) }
    }
    
    //-------------------------------------//
    // MARK: - SAVE / FETCH VERY FIRST VISIT STATUS
    
    static func saveVeryFirstVisit(status: Bool)
    {
        do {
            let encoder = JSONEncoder()
            let encodedStatus = try encoder.encode(status)
            defaults.set(encodedStatus, forKey: AccountKeys.isVeryFirstVisitStatus)
        } catch {
            print("failed ato save very first visit status"); return
        }
    }
    
    
    static func fetchVeryFirstVisitStatus() -> Bool
    {
        guard let visitStatusData = defaults.object(forKey: AccountKeys.isVeryFirstVisitStatus) as? Data
        else { return true }
        
        do {
            let decoder = JSONDecoder()
            let fetchedStatus = try decoder.decode(Bool.self, from: visitStatusData)
            return fetchedStatus
        } catch {
            print("unable to load very first visit status")
            return true
        }
    }
    
    //-------------------------------------//
    // MARK: - SAVE / FETCH VISIT POST DISMISSAL STATUS (FOR LOGO LAUNCHER)
    
    static func saveFirstVisitPostDismissal(status: Bool)
    {
        do {
            let encoder = JSONEncoder()
            let encodedStatus = try encoder.encode(status)
            defaults.set(encodedStatus, forKey: AccountKeys.isFirstVisitPostDismissalStatus)
        } catch {
            print("failed ato save first visit post dismissal status"); return
        }
    }
    
    
    static func fetchFirstVisitPostDismissalStatus() -> Bool
    {
        guard let visitStatusData = defaults.object(forKey: AccountKeys.isFirstVisitPostDismissalStatus) as? Data
        else { return true }
        
        do {
            let decoder = JSONDecoder()
            let fetchedStatus = try decoder.decode(Bool.self, from: visitStatusData)
            return fetchedStatus
        } catch {
            print("unable to load first visit post dismissal status")
            return true
        }
    }
    
    //-------------------------------------//
    // MARK: - COURSE PERSISTENCE
    
    static func updateWith(course: SNCourseProject, actionType: ProgressPersistenceActionType, completed: @escaping (SNError?) -> Void)
    {
        fetchCompletedCourses { result in
            switch result {
            case .success(var courses):
                switch actionType {
                case .complete:
                    courses.append(course)
                    
                case .incomplete:
                    courses.removeAll { $0.title == course.title }
                }
                completed(save(completedCourses: courses))
                
            case .failure(let error):
                completed(error)
            }
        }
    }
    
    
    static func updateWith(project: SNCourseProject, actionType: ProgressPersistenceActionType, completed: @escaping (SNError?) -> Void)
    {
        fetchCompletedProjects { result in
            switch result {
            case .success(var projects):
                switch actionType {
                case .complete:
                    projects.append(project)
                    
                case .incomplete:
                    projects.removeAll { $0.title == project.title }
                }
                completed(save(completedProjects: projects))
                
            case .failure(let error):
                completed(error)
            }
        }
    }
    
    
    static func updateLoggedInStatus(loggedIn: Bool)
    {
        guard loggedIn else {
            defaults.set(false, forKey: AccountKeys.isLoggedIn)
            return
        }
        defaults.set(true, forKey: AccountKeys.isLoggedIn)
        return
    }
    
    
    static func fetchCompletedCourses(completed: @escaping (Result<[SNCourseProject], SNError>) -> Void) {
        guard let completedCoursesData = defaults.object(forKey: AccountKeys.completedCourses) as? Data else {
            completed(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let completedCourses = try decoder.decode([SNCourseProject].self, from: completedCoursesData)
            completed(.success(completedCourses))
        } catch {
            completed(.failure(.failedToLoadProgress))
        }
    }
    
    
    static func fetchCompletedProjects(completed: @escaping (Result<[SNCourseProject], SNError>) -> Void) {
        guard let completedProjectsData = defaults.object(forKey: AccountKeys.completedProjects) as? Data else {
            completed(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let completedProjects = try decoder.decode([SNCourseProject].self, from: completedProjectsData)
            completed(.success(completedProjects))
        } catch {
            completed(.failure(.failedToLoadProgress))
        }
    }
    
    
    static func save(completedCourses: [SNCourseProject]) -> SNError?
    {
        do {
            let encoder = JSONEncoder()
            let encodedCompletedCourses = try encoder.encode(completedCourses)
            defaults.setValue(encodedCompletedCourses, forKey: AccountKeys.completedCourses)
            return nil
        } catch {
            return .failedToSaveProgress
        }
    }
    
    
    static func save(completedProjects: [SNCourseProject]) -> SNError?
    {
        do {
            let encoder = JSONEncoder()
            let encodedCompletedProjects = try encoder.encode(completedProjects)
            defaults.setValue(encodedCompletedProjects, forKey: AccountKeys.completedProjects)
            return nil
        } catch {
            return .failedToSaveProgress
        }
    }
    
    //-------------------------------------//
    // MARK: - LOGIN PERSISTENCE
    
    static func retrieveLoggedInStatus() -> Bool
    {
        let loggedInStatus = defaults.bool(forKey: AccountKeys.isLoggedIn)
        guard loggedInStatus else { return false }
        return true
    }
}
