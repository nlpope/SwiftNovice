//  File: SNTabBarController.swift
//  Project: SwiftNovice
//  Created by: Noah Pope on 7/15/24.

import UIKit

class SNTabBarController: UITabBarController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setUpVCs()
        setupKeyboardHiding()
    }
    
    
    func setUpVCs() { viewControllers = [createPrerequisitesNC(), createProjectsNC()] }
    
    
    func createPrerequisitesNC() -> UINavigationController
    {
        let prereqsVC = CoursesVC()
        prereqsVC.title = "Courses"
        prereqsVC.tabBarItem.image = SFSymbols.courses
        
        return UINavigationController(rootViewController: prereqsVC)
    }
    
    
    func createProjectsNC() -> UINavigationController
    {
        let bookmarksVC = ProjectsVC()
        bookmarksVC.title = "Bookmarks"
        bookmarksVC.tabBarItem.image = SFSymbols.bookmarks
        
        return UINavigationController(rootViewController: bookmarksVC)
    }
}
