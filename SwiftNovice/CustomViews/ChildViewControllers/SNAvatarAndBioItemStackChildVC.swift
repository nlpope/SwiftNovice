//
//  SNAvatarAndBioItemStackChildVC.swift
//  SwiftNovice
//
//  Created by Noah Pope on 7/22/24.
//

import UIKit

class SNAvatarAndBioItemStackChildVC: UIViewController {

    let stackView       = UIStackView()
    let avatarImageView = SNAvatarImageView(frame: .zero)
    let courseBio       = SNCourseBioItemView()
    
    
    var course: Prerequisite!

    init(course: Prerequisite) {
        super.init(nibName: nil, bundle: nil)
        self.course = course
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackgroundView()
        layoutUI()
        configureBioItemView()
        configureStackView()
    }
    
    
    private func configureBackgroundView() {
        view.layer.cornerRadius = 18
        view.backgroundColor    = .secondarySystemBackground
    }
    
    
    private func configureBioItemView() {
        courseBio.set(courseTitle: course.courseName, bioText: course.courseBio, price: course.price)
    }
    
    
    private func configureStackView() {
        stackView.axis          = .horizontal
        stackView.distribution  = .equalSpacing
        
        stackView.addArrangedSubview(avatarImageView)
        stackView.addArrangedSubview(courseBio)
    }
    
    
    private func layoutUI() {
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        let  padding: CGFloat = 20
        // add constraints
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
}
