//
//  PrereqsVC.swift
//  SwiftNovice
//
//  Created by Noah Pope on 7/15/24.
//

import UIKit

class PrereqsVC: SNDataLoadingVC {
    // set mini tutorial as alert for instr. on how to unlock next tab
    // see anki - UserDefaults for tracking if users 1st time on screen
    
    let tableView               = UITableView()
    var prerequisites           = [Prerequisite]()
    var completedPrerequisites  = [Prerequisite]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationVC()
        configureTableView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        getPrerequisitesFromServer()
//        loadProgressFromPersistence()
        print(self.prerequisites)
    }
    
    
    func configureNavigationVC() {
        view.backgroundColor    = .systemBackground
        title                   = "Prerequisites"
        navigationController?.navigationBar.prefersLargeTitles = true
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
    
    
    func saveProgressInPersistence(withCourse course: Prerequisite, toggleType: Bool) {
//        showLoadingView()
        let actionType: CoursePersistenceActionType = toggleType ? .complete : .incomplete
        
        PersistenceManager.updateWith(course: course, actionType: actionType) { [weak self] error in
            guard let self = self else { return }
//            self.dismissLoadingView()
            
            guard let error else {
                switch actionType {
                case .complete:
                    // PRESENT CONFETTI ANIMATION ON MAIN THREAD - CREATE IN UIVC+EXT
                    self.presentSNAlertOnMainThread(alertTitle: "Congratulations!", message: "Good work on completing this prerequisite. Keep going, you've got this 🥳.", buttonTitle: "Ok")
                case .incomplete:
                    self.presentSNAlertOnMainThread(alertTitle: "Course marked incomplete", message: "We have successfully removed this course from your completed lsit.", buttonTitle: "Ok")
                }
                
//                loadProgressFromPersistence()
                return
            }
            
            self.presentSNAlertOnMainThread(alertTitle: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
        }
    }
    
    
    func getPrerequisitesFromServer() {
        showLoadingView()
        NetworkManager.shared.getPrerequisites { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result {
            case .success(let prerequisites):
                self.prerequisites = prerequisites
                updateUI()
            case .failure(let error):
                self.presentSNAlertOnMainThread(alertTitle: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    
    func loadProgressFromPersistence() {
        showLoadingView()
        PersistenceManager.retrieveCompletedCourses { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result {
            case .success(let prerequisites):
                self.completedPrerequisites = prerequisites
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
}


extension PrereqsVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return prerequisites.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell            = tableView.dequeueReusableCell(withIdentifier: PrerequisiteCell.reuseID) as! PrerequisiteCell
        let prerequisite    = prerequisites[indexPath.row]
        
        cell.set(prerequisite: prerequisite)
        cell.backgroundColor = completedPrerequisites.contains(prerequisite) ? .systemGreen : .systemBackground
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let prerequisite    = prerequisites[indexPath.row]
        let destVC          = CourseDetailsVC(courseName: prerequisite.courseName, delegate: self)
        let navController   = UINavigationController(rootViewController: destVC)
        
        present(navController, animated: true)
    }
}


extension PrereqsVC: CourseDetailsVCDelegate {
    
    func followCourseLink() {
       // open safari and go to course link
    }
    
    
    func toggleCourseCompletion(onCourse course: Prerequisite, toggleType: Bool) {
        // reload data
        // play confetti animation
        // followed by congrats/keep going alert
        
        navigationController?.dismiss(animated: true)
        saveProgressInPersistence(withCourse: course, toggleType: toggleType)
        loadProgressFromPersistence()
        
    }
}

// create alert that pops up here after account creation - 'this app is free but to progress you must buy 1 prerequisite. You will spend no more than $45 should you wish to continue" - this refers to hacking with swift by Paul Hudson
