//
//  SNSecondaryLabel.swift
//  SwiftNovice
//
//  Created by Noah Pope on 7/18/24.
//

import UIKit

class SNSecondaryLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(fontSize: CGFloat) {
        self.init(frame: .zero)
        font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
    }
    
    
    convenience init(link: String) {
        self.init(frame: .zero)
        
    }
    
    
    private func configure() {
        textColor                                   = .secondaryLabel
        adjustsFontSizeToFitWidth                   = true
        minimumScaleFactor                          = 0.75
        lineBreakMode                               = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints   = false
    }
}
