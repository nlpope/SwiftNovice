//
//  SNSelectionDetailsSuperVC.swift
//  SwiftNovice
//
//  Created by Noah Pope on 7/24/24.
//

import UIKit

class SNSelectionDetailsSuperVC<T: Codable>: SNDataLoadingVC {
    
    // see note 1 in app delegate
    let titleLabel                  = SNTitleLabel(textAlignment: .left, fontSize: 20, lineBreakMode: .byWordWrapping)
    let selectedItemImageView       = SNAvatarImageView(frame: .zero)
    let bioDetailItemView           = SNDetailItemView()
    let priceDetailItemView         = SNDetailItemView()
    let callToActionButton          = SNButton()
    let toggleButton                = UIButton() // set your TAMIC
    let toggleLabel                 = SNSecondaryTitleLabel(fontSize: 18)
    
    var selectedItem: T!
    var selectionCompleted: Bool    = false
    
    
    init(selectedItem: T) {
        super.init(nibName: nil, bundle: nil)
        self.selectedItem = selectedItem
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
        callToActionButton.addTarget(self, action: #selector(callToActionButtonTapped), for: .touchUpInside)
        toggleButton.addTarget(self, action: #selector(toggleButtonTapped), for: .touchUpInside)
        toggleButton.setImage(SFSymbols.incomplete, for: .normal)
        toggleLabel.text    = "Completed"
    }
    
    
    func layoutUIElements() {
        let edgePadding: CGFloat    = 20
        let elementPadding: CGFloat = 5
        
        view.addSubviews(titleLabel, selectedItemImageView, bioDetailItemView, priceDetailItemView, callToActionButton, toggleButton, toggleLabel)

        toggleButton.translatesAutoresizingMaskIntoConstraints          = false
        bioDetailItemView.translatesAutoresizingMaskIntoConstraints     = false
        priceDetailItemView.translatesAutoresizingMaskIntoConstraints   = false
        
        // previous constraints = pieces in relation to each other
        // below constraints    = whole unit in relation to this VC
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: edgePadding),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -edgePadding),
            titleLabel.heightAnchor.constraint(equalToConstant: 55),
            
            //avatar image
            selectedItemImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: elementPadding),
            selectedItemImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: edgePadding),
            selectedItemImageView.heightAnchor.constraint(equalToConstant: 150),
            selectedItemImageView.widthAnchor.constraint(equalToConstant: 150),
            
            priceDetailItemView.topAnchor.constraint(equalTo: selectedItemImageView.bottomAnchor, constant: elementPadding),
            priceDetailItemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: edgePadding),
            priceDetailItemView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -edgePadding),
            
            callToActionButton.topAnchor.constraint(equalTo: priceDetailItemView.bottomAnchor, constant: 30),
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: edgePadding),
            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -edgePadding),
            
            toggleButton.topAnchor.constraint(equalTo: callToActionButton.bottomAnchor, constant: 25),
            toggleButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: edgePadding),
            toggleButton.widthAnchor.constraint(equalToConstant: 25),
            toggleButton.heightAnchor.constraint(equalToConstant: 25),
            
            toggleLabel.topAnchor.constraint(equalTo: callToActionButton.bottomAnchor, constant: 28),
            toggleLabel.leadingAnchor.constraint(equalTo: toggleButton.trailingAnchor, constant: elementPadding),
            toggleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -edgePadding),
            
            bioDetailItemView.topAnchor.constraint(equalTo: toggleLabel.bottomAnchor, constant: 25),
            bioDetailItemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: edgePadding),
            bioDetailItemView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -edgePadding)
        ])
    }
    
    
    @objc func callToActionButtonTapped() {}
  
    
    @objc func toggleButtonTapped() {
        selectionCompleted = !selectionCompleted
        let imageToDisplay = selectionCompleted ? SFSymbols.complete : SFSymbols.incomplete
        toggleButton.setImage(imageToDisplay, for: .normal)
        toggleLabel.textColor = selectionCompleted ? .systemGreen : .secondaryLabel
    }
    
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
}

