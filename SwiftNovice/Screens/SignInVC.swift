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
    var userExists          = true
    var passwordIsCorrect   = true
    var isUsernameEntered: Bool { return !usernameTexField.text!.isEmpty }
    var isPasswordEntered: Bool { return !passwordTextField.text!.isEmpty }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubviews(logoImageView, usernameTexField, passwordTextField, callToActionButton, signUpLabel)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        usernameTexField.text = ""
        passwordTextField.text = ""
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }
    
    
    @objc func pushPrereqsVC() {
        guard isUsernameEntered, isPasswordEntered else {
            presentSNAlertOnMainThread(alertTitle: "Empty username or password", message: "The username or password field has been left blank. Please enter a value or sign up if you do not have an account.", buttonTitle: "Ok")
            return
        }
        
        guard userExists, passwordIsCorrect else {
            presentSNAlertOnMainThread(alertTitle: "Wrong username or password", message: "The username or password is incorrect. Please try again or sign up if you do not have an account", buttonTitle: "Ok")
            return
        }
        
        usernameTexField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
        let prereqsVC = PrereqsVC(username: usernameTexField.text!)
        navigationController?.pushViewController(prereqsVC, animated: true)
    }
    
    
    func configureLogoImageView() {
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = Images.snLogo
        
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 120),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 200),
            logoImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    
    func configureTextField() {
        usernameTexField.delegate = self
        
        NSLayoutConstraint.activate([
            usernameTexField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 50),
            usernameTexField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            usernameTexField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            usernameTexField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}


extension SignInVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushPrereqsVC()
        return true
    }
}
