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
    var completedProjects = [Project]()

    
    init(project: Project, completedProjects: [Project], delegate: SNProjectDetailsChildVCDelegate) {
        super.init(selectedItem: project)
        self.completedProjects = completedProjects
        self.delegate = delegate
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureToggleButton()
    }
    
    
    private func configureItems() {
        priceDetailItemView.isHidden    = true
        titleLabel.text                 = selectedItem.projectName
        selectedItemImageView.downloadImage(fromURL: selectedItem.avatarUrl)
        bioDetailItemView.set(imageType: .bio, text: selectedItem.projectBio)
        callToActionButton.set(backgroundColor: .black, title: "Go to project")
    }
    
    
    private func configureToggleButton() {
        selectionCompleted = completedProjects.contains(selectedItem) ? true : false
        let imageToDisplay = selectionCompleted ? SFSymbols.complete : SFSymbols.incomplete
        toggleButton.setImage(imageToDisplay, for: .normal)
        toggleLabel.textColor = selectionCompleted ? .systemGreen : .secondaryLabel
    }
    
    
    override func callToActionButtonTapped() {
        delegate.followLink(forProject: selectedItem)
    }
    
    
    override func toggleButtonTapped() {
        super.toggleButtonTapped()
        delegate.toggleCourseCompletion(onProject: selectedItem, toggleType: selectionCompleted)
    }
}
