//
//  ProjectsVC.swift
//  SwiftNovice
//
//  Created by Noah Pope on 7/15/24.
//

import UIKit

class ProjectsVC: SNDataLoadingVC {
    // set mini tutorial as alert for instr. on how to unlock next tab
    // see anki - UserDefaults for tracking if users 1st time on screen
    
    let tableView               = UITableView()
    var projects                = [Project]()
    var completedProjects       = [Project]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        configureTableView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        getProjectsFromServer()
        loadProgressFromPersistence()
    }
    
    
    func configureNavigation() {
        let signOutButton       = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(signOut))
        view.backgroundColor                                    = .systemBackground
        title                                                   = "Projects"
        navigationItem.rightBarButtonItem                       = signOutButton
        navigationController?.navigationBar.prefersLargeTitles  = true
    }
    
    
    func configureTableView() {
        view.addSubview(tableView)
        
        tableView.frame         = view.bounds
        tableView.rowHeight     = 80
        tableView.delegate      = self
        tableView.dataSource    = self
        tableView.removeExcessCells()
        
        tableView.register(ProjectCell.self, forCellReuseIdentifier: ProjectCell.reuseID)
    }
    
    
    func getProjectsFromServer() {
        showLoadingView()
        NetworkManager.shared.getProjects { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result {
            case .success(let projects):
                self.projects = projects
                updateUI()
            case .failure(let error):
                self.presentSNAlertOnMainThread(alertTitle: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    
    func saveProgressInPersistence(withProject project: Project, toggleType: Bool) {
        showLoadingView()
        let actionType: ProgressPersistenceActionType = toggleType ? .complete : .incomplete
        
        PersistenceManager.updateWith(project: project, actionType: actionType) { [weak self] error in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            guard let error else {
                switch actionType {
                case .complete:
                    // PRESENT CONFETTI ANIMATION ON MAIN THREAD - CREATE IN UIVC+EXT
                    self.presentSNAlertOnMainThread(alertTitle: "Congratulations!", message: "Good work on completing this project. Keep going, you've got this 🥳.", buttonTitle: "Ok")
                case .incomplete:
                    self.presentSNAlertOnMainThread(alertTitle: "Course marked incomplete", message: "We have successfully removed this course from your completed lsit.", buttonTitle: "Ok")
                }
                
                return
            }
            
            self.presentSNAlertOnMainThread(alertTitle: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
        }
    }
    
    
    func loadProgressFromPersistence() {
        PersistenceManager.retrieveCompletedProjects { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let projects):
                self.completedProjects = projects
                updateUI()
                
            case .failure(let error):
                self.presentSNAlertOnMainThread(alertTitle: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    
    func updateUI() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.view.bringSubviewToFront(self.tableView)
        }
    }
    
    
    @objc func signOut() {
        PersistenceManager.updateLoggedInStatus(loggedIn: false)
        
        let signInVC = SignInVC()
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootVC(signInVC, animated: true)
    }
}


extension ProjectsVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projects.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell            = tableView.dequeueReusableCell(withIdentifier: ProjectCell.reuseID) as! ProjectCell
        let project         = projects[indexPath.row]
        
        cell.set(project: project)
        cell.backgroundColor = completedProjects.contains(project) ? .systemGreen : .systemBackground
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let project             = projects[indexPath.row]
        let destVC              = SNProjectDetailsChildVC(project: project, delegate: self)
        let navController       = UINavigationController(rootViewController: destVC)
        
        present(navController, animated: true)
    }
}


extension ProjectsVC: SNProjectDetailsChildVCDelegate {
    func toggleCourseCompletion(onProject project: Project, toggleType: Bool) {
        navigationController?.dismiss(animated: true)
        saveProgressInPersistence(withProject: project, toggleType: toggleType)
        loadProgressFromPersistence()
    }
    
    func followLink(forProject project: Project) {
        print("delegate reached for course link")
    }
}


extension ProjectsVC: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidAttemptToDismiss(_ presentationController: UIPresentationController) {
        print("about to dismiss")
    }
}
