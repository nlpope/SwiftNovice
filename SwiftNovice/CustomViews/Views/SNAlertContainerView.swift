//
//  SNAlertContainerView.swift
//  SwiftNovice
//
//  Created by Noah Pope on 7/20/24.
//

import UIKit

class SNAlertContainerView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    private func configure() {
       backgroundColor                           = .systemBackground
       layer.cornerRadius                        = 16
       layer.borderWidth                         = 2
       layer.borderColor                         = UIColor.white.cgColor
       translatesAutoresizingMaskIntoConstraints = false
    }

}
