//
//  SNEmptyStateView.swift
//  SwiftNovice
//
//  Created by Noah Pope on 7/15/24.
//

import UIKit

class SNEmptyStateView: UIView {
    
    let messageLabel        = SNTitleLabel(textAlignment: .center, fontSize: 30)
    let logoImageView       = UIImageView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(message: String) {
        self.init(frame: .zero)
        messageLabel.text = message
    }
    
}
