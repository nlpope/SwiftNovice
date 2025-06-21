//  File: CourseProjectsVC.swift
//  Project: SwiftNovice
//  Created by: Noah Pope on 6/21/25.

#warning("so keep everything the same but present an alert to ask user if they want to mark it complete/incomplete or just want to bookmark/unbookmark the project")
import UIKit
import SafariServices

class CourseProjectsVC: SNDataLoadingVC
{
    var projects = [SNCourseProject]()
    var filteredProjects = [SNCourseProject]()
    var completedProjects = [SNCourseProject]()
    var bookmarkedProjects = [SNCourseProject]()
    
    var isSearching = false
    var editModeOn = false {
        didSet { tableView.isEditing = editModeOn ? true : false; configNavigation() }
    }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        configNavigation()
        configureTableView()
    }
    
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        fetchProjectsFromServer()
        loadProgressFromPersistence()
    }
    
    
    func configNavigation()
    {
        let accountButton = UIBarButtonItem(title: "", image: SFSymbols.account, target: self, action: #selector(openAccountMenu))
        
        view.backgroundColor = .systemBackground
        title = "Projects\n"
        navigationItem.rightBarButtonItem = accountButton
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    func configureTableView()
    {
        view.addSubview(tableView)
        
        tableView.frame = view.bounds
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        tableView.removeExcessCells()
        
        tableView.register(ProjectCell.self, forCellReuseIdentifier: ProjectCell.reuseID)
    }
    
    
    func fetchProjectsFromServer()
    {
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
    
    
    func saveProgressInPersistence(withProject project: SNCourseProject, toggleType: Bool)
    {
        showLoadingView()
        let actionType: ProgressPersistenceActionType = toggleType ? .complete : .incomplete
        
        PersistenceManager.updateWith(project: project, actionType: actionType) { [weak self] error in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            guard let error else {
                switch actionType {
                case .complete:
                    self.presentSNAlertOnMainThread(alertTitle: "Congratulations!", message: "Good work on completing this project. Keep going, you've got this 🥳.", buttonTitle: "Ok")
                case .incomplete:
                    self.presentSNAlertOnMainThread(alertTitle: "Course marked incomplete", message: "We have successfully removed this project from your completed lsit.", buttonTitle: "Ok")
                }
                
                return
            }
            
            self.presentSNAlertOnMainThread(alertTitle: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
        }
    }
    
    
    func loadProgressFromPersistence()
    {
        PersistenceManager.fetchCompletedProjects { [weak self] result in
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
    
   
    func updateUI()
    {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.view.bringSubviewToFront(self.tableView)
        }
    }
    
    
    @objc func openAccountMenu()
    {
        let destVC = AccountVC()
        destVC.delegate = self
        if let acctVCPresentationController = destVC.presentationController as? UISheetPresentationController {
            acctVCPresentationController.detents = [.medium()]
        }
        self.present(destVC, animated: true)
    }
}


extension ProjectsVC: UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    { return projects.count }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProjectCell.reuseID) as! ProjectCell
        let project = projects[indexPath.row]
        
        cell.set(project: project)
        cell.backgroundColor = completedProjects.contains(project) ? .systemGreen : .systemBackground
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let project = projects[indexPath.row]
        let destVC = SNProjectDetailsChildVC(project: project, completedProjects: completedProjects, delegate: self)
        let navController = UINavigationController(rootViewController: destVC)
        
        present(navController, animated: true)
    }
}


extension ProjectsVC: SNProjectDetailsChildVCDelegate
{
    func toggleCourseCompletion(onProject project: SNCourseProject, toggleType: Bool)
    {
        navigationController?.dismiss(animated: true)
        saveProgressInPersistence(withProject: project, toggleType: toggleType)
        loadProgressFromPersistence()
    }
    
    
    func followLink(forProject project: SNCourseProject)
    {
        print("delegate reached for course link")
        navigationController?.dismiss(animated: true)
        guard let url = URL(string: project.projectLink) else {
            presentSNAlertOnMainThread(alertTitle: "Invalid URL", message: "The url attached to this project is invalid", buttonTitle: "Ok")
            return
        }
        presentSafariVC(with: url)
    }
}


extension ProjectsVC: AccountVCDelegate
{
    func signOut()
    {
        navigationController?.dismiss(animated: true)
        PersistenceManager.updateLoggedInStatus(loggedIn: false)
        let signInVC = SignInVC()
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootVC(signInVC, animated: true)
    }
    
    
    func editPassword()
    {
        navigationController?.dismiss(animated: true)
        print("edit password tapped")
    }
    
    
    func seeInstructions()
    {
        navigationController?.dismiss(animated: true)
        displayTutorialPromptOne()
    }
    
    
    func deleteAccount()
    {
        navigationController?.dismiss(animated: true)
        print("delete account tapped")
    }
}


extension ProjectsVC: UIAdaptivePresentationControllerDelegate
{
    func presentationControllerDidAttemptToDismiss(_ presentationController: UIPresentationController) {
        print("about to dismiss")
    }
}
