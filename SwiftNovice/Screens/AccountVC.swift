//
//  AccountVC.swift
//  SwiftNovice
//
//  Created by Noah Pope on 7/23/24.
//

import UIKit

protocol AccountVCDelegate: AnyObject {
    func signOut()
    func editPassword()
    func seeInstructions()
    func deleteAccount()
}


class AccountVC: UIViewController {

    let tableView       = UITableView()
    let menuOptions     = [
        "Sign Out",
        "Edit password",
        "See instructions",
        "Delete Account"
    ]
    
    weak var delegate: AccountVCDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        configureTableView()
    }
    
    
    func configureTableView() {
        view.addSubview(tableView)
        
        tableView.frame         = view.bounds
        tableView.rowHeight     = 40
        tableView.delegate      = self
        tableView.dataSource    = self
        tableView.removeExcessCells()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
}


extension AccountVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuOptions.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell                = tableView.dequeueReusableCell(withIdentifier: "cell")!
        let menuOption          = menuOptions[indexPath.row]
        cell.textLabel?.text    = menuOption
        if menuOption == "Delete Account" { cell.textLabel?.textColor = .systemRed }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedOption = menuOptions[indexPath.row]
        
        if selectedOption == "Sign Out" { delegate.signOut() }
        else if selectedOption == "Edit password" { delegate.editPassword() }
        else if selectedOption == "See instructions" { delegate.seeInstructions() }
        else if selectedOption == "Delete Account" { delegate.deleteAccount() }
    }
}


