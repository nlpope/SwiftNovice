//
//  ProjectsVC.swift
//  SwiftNovice
//
//  Created by Noah Pope on 7/15/24.
//

import UIKit

class ProjectsVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureNavigation()
    }
    
    func configureNavigation() {
        let signOutButton       = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(signOut))
        view.backgroundColor                                    = .systemBackground
        title                                                   = "Projects"
        navigationItem.rightBarButtonItem                       = signOutButton
        navigationController?.navigationBar.prefersLargeTitles  = true
    }
    
    
    @objc func signOut() {
        PersistenceManager.updateLoggedInStatus(loggedIn: false)
        
        let signInVC = SignInVC()
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootVC(signInVC, animated: true)
    }
}
