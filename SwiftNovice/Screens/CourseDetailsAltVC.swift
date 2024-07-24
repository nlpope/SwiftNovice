//
//  CourseDetailsAltVC.swift
//  SwiftNovice
//
//  Created by Noah Pope on 7/24/24.
//

import UIKit

protocol CourseDetailsVCDelegate {
    func followCourseLink()
    func toggleCourseCompletion(onCourse course: Prerequisite, toggleType: Bool)
}

class CourseDetailsAltVC: SNDataLoadingVC {
    
    // see note 1 in app delegate
    let titleLabel          = SNTitleLabel(textAlignment: .left, fontSize: 30)
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
        titleLabel.text = course.courseName
        courseImageView.downloadImage(fromURL: course.avatarUrl)
        bioDetailItemView.set(imageType: .bio, text: course.courseBio)
        priceDetailItemView.set(imageType: .price, text: String(course.price))
        callToActionButton.addTarget(self, action: #selector(goToCourse), for: .touchUpInside)
    }
    
    
    func layoutUIElements() {
        view.addSubviews(titleLabel, courseImageView, bioDetailItemView, priceDetailItemView, callToActionButton, toggleButton, toggleLabel)
        toggleButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
        ])
    }
    
    
    @objc func goToCourse() {
        print("going to course link via safari")
    }
  
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
}

