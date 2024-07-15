//
//  UIResponder+Utils.swift
//  SwiftNovice
//
//  Created by Noah Pope on 7/15/24.
//

import UIKit

extension UIResponder {
    
    // MARK: KEYBOARD
    private struct Static {
        static weak var responder: UIResponder?
    }
    
    
    static func currentResponder() -> UIResponder? {
        Static.responder = nil
        UIApplication.shared.sendAction(#selector(UIResponder._trap), to: nil, from: nil, for: nil)
        return Static.responder
    }
    
    
    @objc private func _trap() {
        Static.responder = self
    }
}
