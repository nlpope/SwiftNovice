//
//  SNCourseDetailsChildVC.swift
//  SwiftNovice
//
//  Created by Noah Pope on 7/24/24.
//

import UIKit

protocol SNCourseDetailsChildVCDelegate: AnyObject {
    func followLink(forCourse course: Prerequisite)
    func toggleCourseCompletion(onCourse course: Prerequisite, toggleType: Bool)
}

class SNCourseDetailsChildVC: SNSelectionDetailsSuperVC<Prerequisite> {

    weak var delegate: SNCourseDetailsChildVCDelegate!

    
    init(course: Prerequisite, delegate: SNCourseDetailsChildVCDelegate) {
        super.init(selectedItem: course)
        self.delegate = delegate
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    
    private func configureItems() {
        titleLabel.text     = selectedItem.courseName
        selectedItemImageView.downloadImage(fromURL: selectedItem.avatarUrl)
        bioDetailItemView.set(imageType: .bio, text: selectedItem.courseBio)
        priceDetailItemView.set(imageType: .price, text: String(format: "%.2f", selectedItem.price))
        callToActionButton.set(backgroundColor: .black, title: "Go to course")
    }
    
    
    override func callToActionButtonTapped() {
        delegate.followLink(forCourse: selectedItem)
    }
}
