//
//  SNProjectDetailsChidVC.swift
//  SwiftNovice
//
//  Created by Noah Pope on 7/25/24.
//

import UIKit

protocol SNProjectDetailsChildVCDelegate: AnyObject {
    func followLink(forProject project: Project)
    func toggleCourseCompletion(onProject project: Project, toggleType: Bool)
}

class SNProjectDetailsChildVC: SNSelectionDetailsSuperVC<Project> {

    weak var delegate: SNProjectDetailsChildVCDelegate!

    
    init(project: Project, delegate: SNProjectDetailsChildVCDelegate) {
        super.init(selectedItem: project)
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
        titleLabel.text     = selectedItem.projectName
        selectedItemImageView.downloadImage(fromURL: selectedItem.avatarUrl)
        bioDetailItemView.set(imageType: .bio, text: selectedItem.projectBio)
        priceDetailItemView.set(imageType: .price, text: String(format: "%.2f", "$0.00"))
        callToActionButton.set(backgroundColor: .black, title: "Go to course")
    }
    
    
    override func callToActionButtonTapped() {
        delegate.followLink(forProject: selectedItem)
    }
}
