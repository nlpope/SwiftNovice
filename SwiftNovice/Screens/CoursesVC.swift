//  File: CoursesVC.swift
//  Project: SwiftNovice
//  Created by: Noah Pope on 7/15/24.

import UIKit
import AVKit
import AVFoundation

// HOMEVC
/** these are uncheckable; only checked autom. when everything in editable coursedetails is checked */
class CoursesVC: SNDataLoadingVC
{
    var dataSource: SNTableViewDiffableDataSource!
    
    var courses = [SNCourse]()
    var filteredCourses = [SNCourse]()
    var completedCourses = [SNCourse]()
    
    var logoLauncher: SNLogoLauncher!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        PersistenceManager.isFirstVisitAfterDismissal = true
        configNavigation()
        configTableView()
    }
    
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        logoLauncher = SNLogoLauncher(targetVC: self)
        if PersistenceManager.fetchFirstVisitPostDismissalStatus() { logoLauncher.configLogoLauncher() }
        else { fetchPrerequisitesFromServer(); loadProgressFromPersistence() }
    }
    
    
    override func viewWillDisappear(_ animated: Bool) { logoLauncher = nil }
    
    
    deinit { logoLauncher.removeAllAVPlayerLayers(); logoLauncher.removeNotifications() }

    //-------------------------------------//
    // MARK: - CONFIGURATION
    
    func configNavigation()
    {
        view.backgroundColor = .systemBackground
        title = "Prerequisites\n"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let accountButton = UIBarButtonItem(title: "", image: SFSymbols.account, target: self, action: #selector(openAccountMenu))

        navigationItem.rightBarButtonItem = accountButton
    }
    
    
    func configTableView()
    {
        view.addSubview(tableView)
        dataSource.delegate = self        
    }
    
    //-------------------------------------//
    // MARK: TUTORIAL PROMPTS
    
    func displayTutorialPromptOne()
    {
        PersistenceManager.isVeryFirstVisit = false
        
        let message = MessageKeys.courseTutorial1
        let ac = UIAlertController(title: "Before you begin", message: message, preferredStyle: .alert)
        let submitAction = UIAlertAction(title: "Continue", style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.displayTutorialPromptTwo()
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    
    func displayTutorialPromptTwo()
    {
        let message = MessageKeys.courseTutorial2
        let ac = UIAlertController(title: "Before you begin", message: message, preferredStyle: .alert)
        let submitAction = UIAlertAction(title: "Continue", style: .default)
        
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    
    func fetchPrerequisitesFromServer()
    {
        showLoadingView()
        NetworkManager.shared.getPrerequisites { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result {
            case .success(let prerequisites):
                self.courses = prerequisites
                updateUI()
                guard PersistenceManager.AccountKeys.isFirstVisitToPrerequisiteScreen else { return }
                displayTutorialPromptOne()
            case .failure(let error):
                self.presentSNAlertOnMainThread(alertTitle: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    
    func saveProgressInPersistence(withCourse course: SNCourseProject, toggleType: Bool)
    {
        showLoadingView()
        let actionType: CoursePersistenceActionType = toggleType ? .complete : .incomplete
        
        PersistenceManager.updateCompletedCourses(withCourse: <#T##SNCourse#>, actionType: <#T##ProjectPersistenceActionType#>) { [weak self] error in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            guard let error else {
                switch actionType {
                case .complete:
                    self.presentSNAlertOnMainThread(alertTitle: "Congratulations!", message: "Good work on completing this prerequisite. Keep going, you've got this 🥳.", buttonTitle: "Ok")
                case .incomplete:
                    self.presentSNAlertOnMainThread(alertTitle: "Course marked incomplete", message: "We have successfully removed this course from your completed lsit.", buttonTitle: "Ok")
                }
                
                return
            }
            
            self.presentSNAlertOnMainThread(alertTitle: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
        }
    }
    
    
    func loadProgressFromPersistence()
    {
        PersistenceManager.fetchCompletedCourses { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let prerequisites):
                self.completedCourses = prerequisites
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
        let destVC      = AccountVC()
        destVC.delegate = self
        if let acctVCPresentationController = destVC.presentationController as? UISheetPresentationController {
            acctVCPresentationController.detents = [.medium()]
        }
        self.present(destVC, animated: true)
    }
    
    
    //-------------------------------------//
    // MARK: - TABLEVIEW DELEGATE & DATASOURCE METHODS
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    { return courses.count }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SNCourseCell", for: indexPath) as! SNCourseCell
        let course = courses[indexPath.row]
        #warning("load if image is present || add a default image. see countryFacts project")
        if let courseImageUrlString = course.avatarURL {
            cell.avatarImageView.image = UIImage(named: "testing")
        }
        
        
    }
}


extension CoursesVC: UITableViewDataSource, UITableViewDelegate
{
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: SNCourseCell.reuseID) as! SNCourseCell
        let course = courses[indexPath.row]
        
        cell.set(prerequisite: course)
        cell.backgroundColor = completedCourses.contains(course) ? .systemGreen : .systemBackground
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let course = courses[indexPath.row]
        let destVC = SNCourseDetailsChildVC(course: course, completedCourses: completedCourses, delegate: self)
        let navController = UINavigationController(rootViewController: destVC)
        
        present(navController, animated: true)
    }
}


extension CoursesVC: SNCourseDetailsChildVCDelegate
{
    func toggleCourseCompletion(onCourse course: SNCourseProject, toggleType: Bool)
    {
        navigationController?.dismiss(animated: true)
        saveProgressInPersistence(withCourse: course, toggleType: toggleType)
        loadProgressFromPersistence()
    }
    
    
    func followLink(forCourse course: SNCourseProject)
    {
        navigationController?.dismiss(animated: true)
        guard let url = URL(string: course.courseLink) else {
            presentSNAlertOnMainThread(alertTitle: "Invalid URL", message: "The url attached to this course is invalid", buttonTitle: "Ok")
            return
        }
        
        presentSafariVC(with: url)
    }
}


extension CoursesVC: AccountVCDelegate
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


extension CoursesVC: UIAdaptivePresentationControllerDelegate
{
    func presentationControllerDidAttemptToDismiss(_ presentationController: UIPresentationController)
    {
        print("about to dismiss")
    }
}
