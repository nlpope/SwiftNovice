//
//  PrereqsVC.swift
//  SwiftNovice
//
//  Created by Noah Pope on 7/15/24.
//

import UIKit

class PrereqsVC: SNDataLoadingVC {
    // see anki - UserDefaults for tracking if users 1st time on screen
    
    let tableView               = UITableView()
    var courses                 = [Prerequisite]()
    var completedCourses        = [Prerequisite]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        configureTableView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        getPrerequisitesFromServer()
        loadProgressFromPersistence()
        if PersistenceManager.Keys.isFirstVisitToPrerequisiteScreen {
            displayTutorialPromptOne()
            PersistenceManager.Keys.isFirstVisitToPrerequisiteScreen = false
        }
    }
    
    
    func configureNavigation() {
        let accountButton       = UIBarButtonItem(title: "", image: SFSymbols.account, target: self, action: #selector(openAccountMenu))

        view.backgroundColor                                    = .systemBackground
        title                                                   = "Prerequisites\n"
        navigationItem.rightBarButtonItem                       = accountButton
        navigationController?.navigationBar.prefersLargeTitles  = true
    }
    
    
    func configureTableView() {
        view.addSubview(tableView)
        
        tableView.frame         = view.bounds
        tableView.rowHeight     = 80
        tableView.delegate      = self
        tableView.dataSource    = self
        tableView.removeExcessCells()
        
        tableView.register(PrerequisiteCell.self, forCellReuseIdentifier: PrerequisiteCell.reuseID)
    }
    
    
    func displayTutorialPromptOne() {
        let message         = "Below are courses that helped me get to where I am on my Swift development journey..."
        let ac              = UIAlertController(title: "Before you begin", message: message, preferredStyle: .alert)
        let submitAction    = UIAlertAction(title: "Continue", style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.displayTutorialPromptTwo()
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    
    func displayTutorialPromptTwo() {
        let message         = "I recommend you complete each in the order they appear as each lesson benefits from the last..."
        let ac              = UIAlertController(title: "Before you begin", message: message, preferredStyle: .alert)
        let submitAction    = UIAlertAction(title: "Continue", style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.displayTutorialPromptThree()
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    
    func displayTutorialPromptThree() {
        let message         = "Once you mark an item as complete, it will glow green. You may change this status anytime..."
        let ac              = UIAlertController(title: "Before you begin", message: message, preferredStyle: .alert)
        let submitAction    = UIAlertAction(title: "Continue", style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.displayTutorialPromptFour()
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    
    func displayTutorialPromptFour() {
        let message         = "You may visit this tutorial again by clicking on the account icon above."
        let ac              = UIAlertController(title: "Before you begin", message: message, preferredStyle: .alert)
        let submitAction    = UIAlertAction(title: "Let's go!", style: .default, handler: nil)
        
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    
    func getPrerequisitesFromServer() {
        showLoadingView()
        NetworkManager.shared.getPrerequisites { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result {
            case .success(let prerequisites):
                self.courses = prerequisites
                updateUI()
            case .failure(let error):
                self.presentSNAlertOnMainThread(alertTitle: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    
    func saveProgressInPersistence(withCourse course: Prerequisite, toggleType: Bool) {
        showLoadingView()
        let actionType: ProgressPersistenceActionType = toggleType ? .complete : .incomplete
        
        PersistenceManager.updateWith(course: course, actionType: actionType) { [weak self] error in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            guard let error else {
                switch actionType {
                case .complete:
                    // PRESENT CONFETTI ANIMATION ON MAIN THREAD - CREATE IN UIVC+EXT
                    self.presentSNAlertOnMainThread(alertTitle: "Congratulations!", message: "Good work on completing this prerequisite. Keep going, you've got this 🥳.", buttonTitle: "Ok")
                case .incomplete:
                    self.presentSNAlertOnMainThread(alertTitle: "Course marked incomplete", message: "We have successfully removed this course from your completed lsit.", buttonTitle: "Ok")
                }
                
                return
            }
            
            self.presentSNAlertOnMainThread(alertTitle: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
        }
    }
    
    
    func loadProgressFromPersistence() {
        PersistenceManager.retrieveCompletedCourses { [weak self] result in
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
    
    
    func updateUI() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.view.bringSubviewToFront(self.tableView)
        }
    }
    
    
    @objc func openAccountMenu() {
        let destVC      = AccountVC()
        destVC.delegate = self
        if let acctVCPresentationController = destVC.presentationController as? UISheetPresentationController {
            acctVCPresentationController.detents = [.medium()]
        }
        self.present(destVC, animated: true)
    }
}


extension PrereqsVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell            = tableView.dequeueReusableCell(withIdentifier: PrerequisiteCell.reuseID) as! PrerequisiteCell
        let course          = courses[indexPath.row]
        
        cell.set(prerequisite: course)
        cell.backgroundColor = completedCourses.contains(course) ? .systemGreen : .systemBackground
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let course          = courses[indexPath.row]
        let destVC          = SNCourseDetailsChildVC(course: course, completedCourses: completedCourses, delegate: self)
        let navController   = UINavigationController(rootViewController: destVC)
        
        present(navController, animated: true)
    }
}


extension PrereqsVC: SNCourseDetailsChildVCDelegate {
    func toggleCourseCompletion(onCourse course: Prerequisite, toggleType: Bool) {
        // reload data
        // followed by congrats/keep going alert
        
        navigationController?.dismiss(animated: true)
        saveProgressInPersistence(withCourse: course, toggleType: toggleType)
        loadProgressFromPersistence()
    }
    
    
    func followLink(forCourse course: Prerequisite) {
        print("delegate reached for course link")
        navigationController?.dismiss(animated: true)
        guard let url = URL(string: course.courseLink) else {
            presentSNAlertOnMainThread(alertTitle: "Invalid URL", message: "The url attached to this course is invalid", buttonTitle: "Ok")
            return
        }
        presentSafariVC(with: url)
    }
}


extension PrereqsVC: AccountVCDelegate {
    func signOut() {
        navigationController?.dismiss(animated: true)
        PersistenceManager.updateLoggedInStatus(loggedIn: false)
        let signInVC = SignInVC()
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootVC(signInVC, animated: true)
    }
    
    
    func editPassword() {
        navigationController?.dismiss(animated: true)
        print("edit password tapped")
    }  
    
    
    func seeInstructions() {
        navigationController?.dismiss(animated: true)
        displayTutorialPromptOne()
    }
    
    
    func deleteAccount() {
        navigationController?.dismiss(animated: true)
        print("delete account tapped")
    }
}


extension PrereqsVC: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidAttemptToDismiss(_ presentationController: UIPresentationController) {
        print("about to dismiss")
    }
}

// create alert that pops up here after account creation - 'this app is free but to progress you must buy 1 prerequisite. You will spend no more than $45 should you wish to continue" - this refers to hacking with swift by Paul Hudson
