//
//  SNLink.swift
//  SwiftNovice
//
//  Created by Noah Pope on 7/18/24.
//

import UIKit

// see note 1 in app delegate
class SNLink: UITextView {

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        self.isUserInteractionEnabled   = true
        self.isSelectable               = true
        self.dataDetectorTypes          = .link
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(text: String) {
        self.init(frame: .zero)
        self.text = text
    }
}
