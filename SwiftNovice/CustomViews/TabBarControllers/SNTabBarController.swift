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
    
    
    func setUpVCs() { viewControllers = [createCoursesNC(), createChallengesNC()] }
    
    
    func createCoursesNC() -> UINavigationController
    {
        let coursesVC = CoursesVC()
        coursesVC.title = "Courses"
        coursesVC.tabBarItem.image = SFSymbols.courses
        
        return UINavigationController(rootViewController: coursesVC)
    }
    
    
    func createChallengesNC() -> UINavigationController
    {
        let challengesVC = ChallengesVC()
        challengesVC.title = "Challenges"
        challengesVC.tabBarItem.image = SFSymbols.challenges
        
        return UINavigationController(rootViewController: challengesVC)
    }
}
