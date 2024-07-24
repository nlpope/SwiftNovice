//
//  SNSecondaryTitleLabel.swift
//  SwiftNovice
//
//  Created by Noah Pope on 7/22/24.
//

import UIKit

class SNSecondaryTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //text alignment is left by default in UILabels
    convenience init(fontSize: CGFloat) {
        self.init(frame: .zero)
        font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
    }
    
    
    private func configure() {
        textColor                                 = .secondaryLabel
        adjustsFontSizeToFitWidth                 = true
        minimumScaleFactor                        = 0.75
        lineBreakMode                             = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }

}
