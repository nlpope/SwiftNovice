//
//  SignInVC.swift
//  SwiftNovice
//
//  Created by Noah Pope on 7/18/24.
//

import UIKit

class SignInVC: UIViewController {
    
    let logoImageView       = UIImageView()
    let usernameTextField   = SNTextField(placeholder: "username")
    let passwordTextField   = SNTextField(placeholder: "password")
    let signInLabel         = SNInteractiveLabel(textToDisplay: "Sign in", fontSize: 18)
    let signUpLabel         = SNInteractiveLabel(textToDisplay: "Don't have an account?", fontSize: 18)
    let forgotLabel         = SNInteractiveLabel(textToDisplay: "Forgot username/password?", fontSize: 18)
    var userExists          = true
    var passwordIsCorrect   = true
    var isUsernameEntered: Bool { return !usernameTextField.text!.isEmpty }
    var isPasswordEntered: Bool { return !passwordTextField.text!.isEmpty }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureLogoImageView()
        configureUsernameTextField()
        configurePasswordTextField()
        configureSignInLabel()
        configureSignUpLabel()
        createDismissKeyboardTapGesture()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        usernameTextField.text = ""
        passwordTextField.text = ""
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    func configureVC() {
        view.backgroundColor = .systemBackground
        view.addSubviews(logoImageView, usernameTextField, passwordTextField, signInLabel, signUpLabel, forgotLabel)
    }
    
    
    func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
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
    
    
    func configureUsernameTextField() {
        usernameTextField.delegate = self
        
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 50),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }  
    
    
    func configurePasswordTextField() {
        passwordTextField.delegate = self
        passwordTextField.isSecureTextEntry = true
        
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 50),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    func configureSignInLabel() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(resetRootVC))
        signInLabel.addGestureRecognizer(tap)
        
        NSLayoutConstraint.activate([
            signInLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 50),
            signInLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    
    func configureSignUpLabel() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(presentSignUpVC))
        signUpLabel.addGestureRecognizer(tap)
        
        NSLayoutConstraint.activate([
            signUpLabel.topAnchor.constraint(equalTo: signInLabel.bottomAnchor, constant: 50),
            signUpLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    
    func configureForgotLabel() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(presentSignUpVC))
        forgotLabel.addGestureRecognizer(tap)
        
        NSLayoutConstraint.activate([
            forgotLabel.topAnchor.constraint(equalTo: signUpLabel.bottomAnchor, constant: 50),
            forgotLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    
    func updateLoggedinStatus(withStatus status: Bool) {
        PersistenceManager.updateLoggedInStatus(loggedIn: status)
    }
    
    
    @objc func resetRootVC() {
        guard isUsernameEntered, isPasswordEntered else {
            presentSNAlertOnMainThread(alertTitle: "Empty username/password", message: "The username or password field has been left blank. Please enter a value or sign up if you do not have an account.", buttonTitle: "Ok")
            return
        }
        
        guard userExists, passwordIsCorrect else {
            presentSNAlertOnMainThread(alertTitle: "Wrong username/password", message: "The username or password is incorrect. Please try again or sign up if you do not have an account", buttonTitle: "Ok")
            return
        }
        
        updateLoggedinStatus(withStatus: true)
        usernameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
        let tabBarController = SNTabBarController()
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootVC(tabBarController)
    }
    
    
    @objc func presentSignUpVC() {
        
    }
    
    
    @objc func presentPasswordReset() {
        print("it works")
    }
}


extension SignInVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        resetRootVC()
        return true
    }
}
