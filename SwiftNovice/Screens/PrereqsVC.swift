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
    
    var username: String!
    let tableView               = UITableView()
    var prerequisites           = [Prerequisite]()
    var completedPrerequisites  = [Prerequisite]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationVC()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        getProgress()
    }
    
    
    func configureNavigationVC() {
        view.backgroundColor    = .systemBackground
        title                   = "Favorites"
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
    
    
    func getProgress() {
        // go to user defaults
        // send results of completes to updateUI
    }
    
    
    func updateCompletedCourses(withCourse course: Prerequisite, toggleType: Bool) {
        showLoadingView()
        let actionType: CoursePersistenceActionType = toggleType ? .complete : .incomplete
        
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
    
    
    // DO I NEED THIS IF I RELOAD THE DATA IN GETPROGRESS()?
    func updateUI(with progress: [Prerequisite]) {
        // if in list of completes returned from 'getProgress()' shade it pale green
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
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let prerequisite    = prerequisites[indexPath.row]
        let destVC          = CourseDetailsVC()
        
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
        updateCompletedCourses(withCourse: course, toggleType: toggleType)
        getProgress()
    }
}

// create alert that pops up here after account creation - 'this app is free but to progress you must buy 1 prerequisite. You will spend no more than $45 should you wish to continue" - this refers to hacking with swift by Paul Hudson
