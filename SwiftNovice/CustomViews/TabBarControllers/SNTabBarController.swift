//
//  SNTabBarController.swift
//  SwiftNovice
//
//  Created by Noah Pope on 7/15/24.
//

import UIKit

class SNTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpVCs()
        setupKeyboardHiding()
    }
    
    
    func setUpVCs() { viewControllers = [createPrerequisitesNC(), createProjectsNC()] }
    
    
    func createPrerequisitesNC() -> UINavigationController {
        let prereqsVC               = PrereqsVC()
        prereqsVC.title             = "Prerequisites"
        prereqsVC.tabBarItem.image  = SFSymbols.prereqs
        
        return UINavigationController(rootViewController: prereqsVC)
    }
    
    
    func createProjectsNC() -> UINavigationController {
        let projectsVC                  = ProjectsVC()
        projectsVC.title                = "Projects"
        projectsVC.tabBarItem.image     = SFSymbols.projects
        
        return UINavigationController(rootViewController: projectsVC)
    }
    
    
//    func createInboxNC() -> UINavigationController {
//        let inboxVC                 = InboxVC()
//        inboxVC.title               = "Inbox"
//        inboxVC.tabBarItem.image    = SFSymbols.inbox
//        
//        return UINavigationController(rootViewController: inboxVC)
//    }
    
    
    
}
