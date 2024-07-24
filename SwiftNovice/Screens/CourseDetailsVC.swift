//
//  CourseDetailsVC.swift
//  SwiftNovice
//
//  Created by Noah Pope on 7/21/24.
//

import UIKit

#warning("this window's drag down dismissal doesn't dealloc. memory - how to do that?")
protocol CourseDetailsVCDelegate {
    func followCourseLink()
    func toggleCourseCompletion(onCourse course: Prerequisite, toggleType: Bool)
}

class CourseDetailsVC: SNDataLoadingVC {

    let courseAvatarBioStackView        = UIView()
    let linkAndCompletionContainerView  = UIView()
    var itemViews                       = [UIView]()
    
    var course: Prerequisite!
    var delegate: CourseDetailsVCDelegate!
    
    
    init(course: Prerequisite, delegate: CourseDetailsVCDelegate!) {
        super.init(nibName: nil, bundle: nil)
        self.course = course
        self.delegate = delegate
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
        configureNavigation()
        layoutUI()
        configureUIElements(with: course)
    }
    
    
    func configureNavigation() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    
    func configureUIElements(with course: Prerequisite) {
        self.add(childVC: SNAvatarAndBioItemStackChildVC(course: course), toContainer: self.courseAvatarBioStackView)
    }
    
    
    func add(childVC: UIViewController, toContainer containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
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
    
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
}

