//
//  CourseDetailsVC.swift
//  SwiftNovice
//
//  Created by Noah Pope on 7/21/24.
//

import UIKit

#warning("this window's drag down dismissal doesn't dealloc. memory - how to do that?")


class CourseDetailsVC: SNDataLoadingVC {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
        layoutUI()
        configureUIElements(with: course)
    }
    
    


    

    
    
    func layoutUI() {
        let padding: CGFloat = 20
        itemViews = [courseAvatarBioStackView, linkAndCompletionContainerView]
        
        for itemView in itemViews {
            view.addSubview(itemView)
            itemView.backgroundColor = .systemPink
            itemView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
            ])
        }
        
        NSLayoutConstraint.activate([
            courseAvatarBioStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            courseAvatarBioStackView.heightAnchor.constraint(equalToConstant: 410),
            
            
            linkAndCompletionContainerView.topAnchor.constraint(equalTo: courseAvatarBioStackView.bottomAnchor, constant: padding),
            linkAndCompletionContainerView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

