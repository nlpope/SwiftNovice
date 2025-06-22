//  File: PersistenceManager.swift
//  Project: SwiftNovice
//  Created by: Noah Pope on 7/20/24.

import Foundation

enum CoursePersistenceActionType
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
            print("failed ato save very first visit status")
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
            print("failed ato save first visit post dismissal status")
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
    
    static func updateCompletedCourses(with course: SNCourse, actionType: CoursePersistenceActionType, completed: @escaping (SNError?) -> Void)
    {
        fetchCourseProgress { result in
            switch result {
            case .success(var courses):
                handle(actionType, for: course, in: &courses) { error in
                    if error != nil { completed(error); return }
                }
                completed(saveAllProgress(for: courses))
            /**--------------------------------------------------------------------------**/
            case .failure(let error):
                completed(error)
            }
        }
    }
    
    
    static func handle(_ actionType: CoursePersistenceActionType, for course: SNCourse, in courses:  inout [SNCourse], completed: @escaping (SNError?) -> Void)
    {
        switch actionType {
        case .complete:
            courses.removeAll { $0.title == course.title }
            courses.append(course)
        /**--------------------------------------------------------------------------**/
        case .incomplete:
            courses.removeAll { $0.title == course.title }
        }
    }
    
    
    static func fetchCourseProgress(completed: @escaping (Result<[SNCourse], SNError>) -> Void)
    {
        guard let completedCoursesData = defaults.object(forKey: AccountKeys.courseProgress) as? Data else {
            completed(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let completedCourses = try decoder.decode([SNCourse].self, from: completedCoursesData)
            completed(.success(completedCourses))
        } catch {
            completed(.failure(.failedToLoadProgress))
        }
    }
    
    
    static func saveAllProgress(for courses: [SNCourse]) -> SNError?
    {
        do {
            let encoder = JSONEncoder()
            let encodedCompletedCourses = try encoder.encode(courses)
            defaults.setValue(encodedCompletedCourses, forKey: AccountKeys.courseProgress)
            return nil
        } catch {
            return .failedToSaveProgress
        }
    }
    
    //-------------------------------------//
    // MARK: - LOGIN PERSISTENCE
    
    static func updateLoggedInStatus(loggedIn: Bool)
    {
        guard loggedIn else {
            defaults.set(false, forKey: AccountKeys.isLoggedIn)
            return
        }
        defaults.set(true, forKey: AccountKeys.isLoggedIn)
        return
    }
    
    
    static func retrieveLoggedInStatus() -> Bool
    {
        let loggedInStatus = defaults.bool(forKey: AccountKeys.isLoggedIn)
        guard loggedInStatus else { return false }
        return true
    }
}
