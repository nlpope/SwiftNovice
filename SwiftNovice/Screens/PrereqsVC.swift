//
//  PrereqsVC.swift
//  SwiftNovice
//
//  Created by Noah Pope on 7/15/24.
//

import UIKit

class PrereqsVC: SNDataLoadingVC {
    // set mini tutorial as alert for instr. on how to unlock next tab
    
    var username: String!
    let tableView       = UITableView()
    var prerequisites   = [Prerequisite]()
    
    
    init(username: String!) {
        super.init(nibName: nil, bundle: nil)
        self.username = username
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationVC()
        
    }
    
    
    func configureNavigationVC() {
        view.backgroundColor    = .systemBackground
        title                   = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    func configureTableView() {
        view.addSubview(tableView)
        
        tableView.frame         = view.bounds
        // see note 10 in app delegate
        tableView.rowHeight     = 80
        tableView.delegate      = self
        tableView.dataSource    = self
        tableView.removeExcessCells()
        
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseID)
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
        let destVC          = PrereqsVC(username: favorite.login)
        
        navigationController?.pushViewController(destVC, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
                
        PersistenceManager.updateWith(favorite: favorites[indexPath.row], actionType: .remove) { [weak self] error in
            guard let self = self else { return }
            // see note 11 in app delegate
            guard let error = error else {
                self.favorites.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .left)
                return
            }
            
            self.presentGFAlertOnMainThread(alertTitle: "Unable to remove", message: error.rawValue, buttonTitle: "Ok")
        }
    }
}

// create alert that pops up here after account creation - 'this app is free but to progress you must buy 1 prerequisite. You will spend no more than $45 should you wish to continue" - this refers to hacking with swift by Paul Hudson
