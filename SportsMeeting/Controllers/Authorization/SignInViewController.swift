//
//  SingInViewController.swift
//  SportsMeeting
//
//  Created by  Sasha Khomenko on 27.02.2023.
//

import UIKit

class SignInViewController: UIViewController {
    
    // MARK: Outlets
    
    // Label
    private let loginImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome Back!"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Gill Sans SemiBold", size: 33)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let adviceLabel: UILabel = {
        let label = UILabel()
        label.text = "Please enter your email address and enter password"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Gill Sans Light", size: 16)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.textColor = .lightGray
        return label
    }()
    
    private let signUpLabel: UILabel = {
        let label = UILabel()
        label.text = "Don't have an account?"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Gill Sans Light", size: 18)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .lightGray
        return label
    }()
    
    // Stack
    private let stackMain: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 20
        return stackView
    }()
    
    private let stackEmail: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    private let stackPassword: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    // Buttons
    private let stackSignUp: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        return stackView
    }()
    
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
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.addTarget(self, action: #selector(signUpBtn), for: .touchUpInside)
        button.setTitleColor(.link, for: .normal)
        button.titleLabel?.font = UIFont(name: "Gill Sans SemiBold", size: 16)
        
        return button
    }()
    
    // Text Field
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.returnKeyType = .continue
        textField.backgroundColor = .secondarySystemBackground
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.returnKeyType = .done
        textField.backgroundColor = .secondarySystemBackground
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let emailIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "mail")
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let passwordIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "lock.fill")
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: VC Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupViews()
        emailTextField.delegate = self
        passwordTextField.delegate = self
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
                    let alert = UIAlertController(title: "Log In Error",
                                                  message: "We were unable to log you in.",
                                                  preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss",
                                                  style: .cancel,
                                                  handler: nil))
                    self.present(alert, animated: true)
                }
            }
        }
    }
    
    // MARK: Constraints
    private func setupViews(){
        view.addSubview(loginImageView)
        NSLayoutConstraint.activate([
            loginImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            loginImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 16),
            loginImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            loginImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        view.addSubview(welcomeLabel)
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: loginImageView.bottomAnchor, constant: 30),
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        view.addSubview(adviceLabel)
        NSLayoutConstraint.activate([
            adviceLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 10),
            adviceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        view.addSubview(stackMain)
        
        stackMain.addArrangedSubview(stackEmail)
        stackEmail.addArrangedSubview(emailIcon)
        stackEmail.addArrangedSubview(emailTextField)
        
        stackMain.addArrangedSubview(stackPassword)
        stackPassword.addArrangedSubview(passwordIcon)
        stackPassword.addArrangedSubview(passwordTextField)
        
        stackMain.addArrangedSubview(forgotPassButton)
        stackMain.addArrangedSubview(loginButton)
        
        NSLayoutConstraint.activate([
            stackMain.topAnchor.constraint(equalTo: adviceLabel.bottomAnchor, constant: 25),
            stackMain.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            stackMain.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            emailIcon.heightAnchor.constraint(equalToConstant: 50),
            emailIcon.widthAnchor.constraint(equalToConstant: 25),
            passwordIcon.heightAnchor.constraint(equalToConstant: 50),
            passwordIcon.widthAnchor.constraint(equalToConstant: 25),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        view.addSubview(stackSignUp)
        stackSignUp.addArrangedSubview(signUpLabel)
        stackSignUp.addArrangedSubview(signUpButton)
        
        NSLayoutConstraint.activate([
            stackSignUp.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackSignUp.topAnchor.constraint(equalTo: stackMain.bottomAnchor, constant: 8),
        ])
    }
}

extension SignInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            signInBtn()
        }
        return true
    }
}
