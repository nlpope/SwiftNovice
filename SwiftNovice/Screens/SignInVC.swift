//
//  SignInVC.swift
//  SwiftNovice
//
//  Created by Noah Pope on 7/18/24.
//

import UIKit

class SignInVC: UIViewController {
    
    let logoImageView       = UIImageView()
    let usernameTexField    = SNTextField(placeholder: "username")
    let passwordTextField   = SNTextField(placeholder: "username")
    let callToActionButton  = SNButton(backgroundColor: .systemBackground, title: "Sign In")
    let signUpLabel         = SNSecondaryLabel(fontSize: 18)
    var isUsernameEntered: Bool { return !usernameTexField.text!.isEmpty }
    var isPasswordEntered: Bool { return !passwordTextField.text!.isEmpty }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubViews(logoImageView, usernameTexField, passwordTextField, callToActionButton, signUpLabel)
    }
}
