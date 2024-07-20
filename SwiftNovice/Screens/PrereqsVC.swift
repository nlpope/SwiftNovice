//
//  PrereqsVC.swift
//  SwiftNovice
//
//  Created by Noah Pope on 7/15/24.
//

import UIKit

class PrereqsVC: UIViewController {
    // set 'honor system' alert before unlocking next screen
    // once user hits 'ok' they'll be asked to provide their github link & their public repos will be scanned for the presence of a GHFollowers repo, if not detected - the projects & inbox tabs will not be unlocked
    var username: String!
    
    
    init(username: String!) {
        super.init(nibName: nil, bundle: nil)
        self.username = username
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
    }
}

// create alert that pops up here after account creation - 'this app is free but to progress you must buy 1 prerequisite. You will spend no more than $45 should you wish to continue" - this refers to hacking with swift by Paul Hudson
