//  File: SNCourseDetailsChildVC.swift
//  Project: SwiftNovice
//  Created by: Noah Pope on 7/24/24.

import UIKit

protocol SNCourseDetailsChildVCDelegate: AnyObject
{
    func followLink(forCourse course: SNCourseProject)
    func toggleCourseCompletion(onCourse course: SNCourseProject, toggleType: Bool)
}

class SNCourseDetailsChildVC: SNSelectionDetailsSuperVC<SNCourseProject>
{
    weak var delegate: SNCourseDetailsChildVCDelegate!
    var completedCourses = [SNCourseProject]()

    
    init(course: SNCourseProject, completedCourses: [SNCourseProject], delegate: SNCourseDetailsChildVCDelegate)
    {
        super.init(selectedItem: course)
        self.completedCourses = completedCourses
        self.delegate = delegate
    }
    
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        configureItems()
    }
    
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        configureToggleButton()
    }
    
    
    private func configureItems()
    {
        titleLabel.text = selectedItem.courseName
        selectedItemImageView.downloadImage(fromURL: selectedItem.avatarUrl)
        bioDetailItemView.set(imageType: .bio, text: selectedItem.courseBio)
        priceDetailItemView.set(imageType: .price, text: String(format: "%.2f", selectedItem.price))
        callToActionButton.set(backgroundColor: .black, title: "Go to course")
    }
    
    
    private func configureToggleButton()
    {
        selectionCompleted = completedCourses.contains(selectedItem) ? true : false
        let imageToDisplay = selectionCompleted ? SFSymbols.complete : SFSymbols.incomplete
        toggleButton.setImage(imageToDisplay, for: .normal)
        toggleLabel.textColor = selectionCompleted ? .systemGreen : .secondaryLabel
    }
    
    
    override func toggleButtonTapped()
    {
        super.toggleButtonTapped()
        delegate.toggleCourseCompletion(onCourse: selectedItem, toggleType: selectionCompleted)
    }
    
    
    override func callToActionButtonTapped() { delegate.followLink(forCourse: selectedItem) }
}
