//
//  CourseDetailsVC.swift
//  SwiftNovice
//
//  Created by Noah Pope on 7/24/24.
//

import UIKit

protocol CourseDetailsVCDelegate {
    func followCourseLink()
    func toggleCourseCompletion(onCourse course: Prerequisite, toggleType: Bool)
}

class CourseDetailsVC: SNDataLoadingVC {
    
    // see note 1 in app delegate
    let titleLabel          = SNTitleLabel(textAlignment: .left, fontSize: 30, lineBreakMode: .byWordWrapping)
    let courseImageView     = SNAvatarImageView(frame: .zero)
    let bioDetailItemView   = SNDetailItemView()
    let priceDetailItemView = SNDetailItemView()
    let callToActionButton  = SNButton(backgroundColor: .systemGreen, title: "Go to course")
    let toggleButton        = UIButton() // set your TAMIC
    let toggleLabel         = SNSecondaryTitleLabel(fontSize: 18)
    
    var course: Prerequisite!
    var delegate: CourseDetailsVCDelegate!
    
    
    init(course: Prerequisite, delegate: CourseDetailsVCDelegate) {
        super.init(nibName: nil, bundle: nil)
        self.course = course
        self.delegate = delegate
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        configureUIElements()
        layoutUIElements()
    }
    
    
    func configureNavigation() {
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))

        view.backgroundColor                = .systemBackground
        navigationItem.rightBarButtonItem   = doneButton
    }
    
    
    func configureUIElements() {
        titleLabel.text     = course.courseName
        // set toggleButton's conditional image
        toggleLabel.text    = "Completed"

        courseImageView.downloadImage(fromURL: course.avatarUrl)
        bioDetailItemView.set(imageType: .bio, text: course.courseBio)
        priceDetailItemView.set(imageType: .price, text: String(course.price))
        callToActionButton.addTarget(self, action: #selector(goToCourse), for: .touchUpInside)
        
        toggleButton.setImage(SFSymbols.incomplete, for: .normal)
    }
    
    
    func layoutUIElements() {
        let edgePadding: CGFloat    = 20
        let elementPadding: CGFloat = 5
        
        view.addSubviews(titleLabel, courseImageView, bioDetailItemView, priceDetailItemView, callToActionButton, toggleButton, toggleLabel)

        toggleButton.translatesAutoresizingMaskIntoConstraints          = false
        bioDetailItemView.translatesAutoresizingMaskIntoConstraints     = false
        priceDetailItemView.translatesAutoresizingMaskIntoConstraints   = false
        
        // previous constraints = pieces in relation to each other
        // below constraints    = whole unit in relation to this VC
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: edgePadding),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -edgePadding),
            titleLabel.heightAnchor.constraint(equalToConstant: 55),
            
            //avatar image
            courseImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: elementPadding),
            courseImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: edgePadding),
            courseImageView.heightAnchor.constraint(equalToConstant: 150),
            courseImageView.widthAnchor.constraint(equalToConstant: 150),
            
            bioDetailItemView.topAnchor.constraint(equalTo: courseImageView.topAnchor, constant: elementPadding),
            bioDetailItemView.leadingAnchor.constraint(equalTo: courseImageView.trailingAnchor, constant: elementPadding),
            bioDetailItemView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -edgePadding),
            bioDetailItemView.heightAnchor.constraint(equalToConstant: 30),
            
            priceDetailItemView.topAnchor.constraint(equalTo: courseImageView.bottomAnchor, constant: elementPadding),
            priceDetailItemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: edgePadding),
            priceDetailItemView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -edgePadding),
            
            callToActionButton.topAnchor.constraint(equalTo: priceDetailItemView.bottomAnchor, constant: 70),
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: edgePadding),
            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -edgePadding),
            
            toggleButton.topAnchor.constraint(equalTo: callToActionButton.bottomAnchor, constant: 25),
            toggleButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: edgePadding),
            toggleButton.widthAnchor.constraint(equalToConstant: 25),
            toggleButton.heightAnchor.constraint(equalToConstant: 25),
            
            toggleLabel.topAnchor.constraint(equalTo: callToActionButton.bottomAnchor, constant: 28),
            toggleLabel.leadingAnchor.constraint(equalTo: toggleButton.trailingAnchor, constant: elementPadding),
            toggleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -edgePadding)
        ])
    }
    
    
    @objc func goToCourse() {
        print("going to course link via safari")
    }
  
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
}

