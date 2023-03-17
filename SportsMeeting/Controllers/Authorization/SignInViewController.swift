//
//  SingInViewController.swift
//  SportsMeeting
//
//  Created by  Sasha Khomenko on 27.02.2023.
//

import UIKit

class SignInViewController: UIViewController {
    var activeTextField : UITextField? = nil
    
    // MARK: Outlets
    
    // Labels
    private let loginImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome Back!"
        label.font = UIFont(name: "Gill Sans SemiBold", size: 33)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let adviceLabel: UILabel = {
        let label = UILabel()
        label.text = "Please enter your email address and enter password"
        label.font = UIFont(name: "Gill Sans Light", size: 16)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.textColor = .lightGray
        return label
    }()
    
    // Buttons
    private lazy var forgotPassButton: UIButton = {
        let button = UIButton()
        button.setTitle("Forgot Password?", for: .normal)
        //button.addTarget(self, action: #selector(), for: .touchUpInside)
        button.setTitleColor(.link, for: .normal)
        button.titleLabel?.font = UIFont(name: "Gill Sans SemiBold", size: 16)
        button.contentHorizontalAlignment = .right
        return button
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.addTarget(self, action: #selector(signInBtn), for: .touchUpInside)
        button.backgroundColor = UIColor(named: "lightGreen")
        button.titleLabel?.font = UIFont(name: "Gill Sans SemiBold", size: 20)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        return button
    }()
    
    private lazy var signUpButton: UIButton = {
        let button = Utilities().attributedButton("Don't have an account?", " Sign Up")
        button.addTarget(self, action: #selector(signUpBtn), for: .touchUpInside)
        return button
    }()
    
    // Containers
    private lazy var emailContainer: UIStackView = {
        let imageView = UIImageView()
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "mail")
        imageView.setDimensions(width: 25, height: 40)
        let stack = Utilities().imageContainerView(withImage: imageView, textField: emailTextField)
        return stack
    }()
    
    private lazy var passwordContainer: UIStackView = {
        let imageView = UIImageView()
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "lock.fill")
        imageView.setDimensions(width: 25, height: 40)
        let stack = Utilities().imageContainerView(withImage: imageView, textField: passwordTextField)
        return stack
    }()
    
    // Text Field
    private lazy var emailTextField: UITextField = {
        let textField = Utilities().textField(withPlaceholder: "Email")
        textField.autocapitalizationType = .none
        textField.returnKeyType = .continue
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = Utilities().textField(withPlaceholder: "Password")
        textField.isSecureTextEntry = true
        textField.autocapitalizationType = .none
        textField.returnKeyType = .done
        return textField
    }()
    
    // MARK: VC Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        hideKeyboard()
    }
    
    // MARK: Actions
    @objc func signUpBtn() {
        let signUpVC = SignUpViewController()
        signUpVC.modalPresentationStyle = .overFullScreen
        present(signUpVC, animated: true, completion: nil)
    }
    
    @objc func signInBtn() {
        guard let email = emailTextField.text,
              !email.isEmpty,
              let password = passwordTextField.text,
              !password.isEmpty,
              password.count >= 8 else {
            return
        }
        
        AuthManager.shared.loginUser(email: email, password: password) { success in
            DispatchQueue.main.async {
                if success {
                    // User logged in
                    let vc = TabBarViewController()
                    vc.modalPresentationStyle = .overFullScreen
                    self.present(vc, animated: true)
                } else {
                    // Error occurred
                    self.showAlert(withTitle: "Log In Error", message: "We were unable to log you in.")
                }
            }
        }
    }
    
    // MARK: Constraints
    private func setupUI(){
        let stackMain = UIStackView(arrangedSubviews: [loginImageView, welcomeLabel, adviceLabel, emailContainer, passwordContainer, forgotPassButton, loginButton,  signUpButton])
        stackMain.translatesAutoresizingMaskIntoConstraints = false
        stackMain.axis = .vertical
        stackMain.spacing = 15
        
        view.addSubview(stackMain)
        NSLayoutConstraint.activate([
            loginImageView.topAnchor.constraint(equalTo: stackMain.topAnchor),
            loginImageView.trailingAnchor.constraint(equalTo: stackMain.trailingAnchor, constant: 16),
            loginImageView.leadingAnchor.constraint(equalTo: stackMain.leadingAnchor, constant: 16),
            loginImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        NSLayoutConstraint.activate([
            stackMain.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackMain.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stackMain.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            stackMain.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40)
        ])
        
        NSLayoutConstraint.activate([
            emailTextField.heightAnchor.constraint(equalToConstant: 40),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}
