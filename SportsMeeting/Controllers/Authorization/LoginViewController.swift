//
//  LoginViewController.swift
//  SportsMeeting
//
//  Created by  Sasha Khomenko on 27.02.2023.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: View
    private var views = LoginView()
    
    // MARK: Lifecycle
    override func loadView() {
        view = views
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        hideKeyboard()
        setupEventHandlers()
    }
    
    // MARK: Actions
    private func setupEventHandlers() {
        views.loginButton.addTarget(self, action: #selector(self.loginButtonTapped), for: .touchUpInside)
        views.registrationButton.addTarget(self, action: #selector(self.registrationButtonTapped), for: .touchUpInside)
    }
    
    @objc func registrationButtonTapped() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            let registrationVC = RegistrationViewController()
            registrationVC.modalPresentationStyle = .overFullScreen
            self.present(registrationVC, animated: true) {
            }
        }
    }
    
    @objc func loginButtonTapped() {
        guard let email = views.emailTextField.text,
              !email.isEmpty,
              let password = views.passwordTextField.text,
              !password.isEmpty,
              password.count >= 8 else {
            self.showAlert(withTitle: "Login Error", message: "Check the data is correct and try again!")
            return
        }
        
        AuthManager.shared.loginUser(email: email, password: password) { success in
            DispatchQueue.main.async {
                if success {
                    let vc = TabBarViewController()
                    vc.modalPresentationStyle = .overFullScreen
                    self.present(vc, animated: true)
                } else {
                    self.showAlert(withTitle: "Log In Error", message: "Check the data is correct and try again!")
                }
            }
        }
    }
}
