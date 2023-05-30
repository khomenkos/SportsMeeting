//
//  LoginView.swift
//  SportsMeeting
//
//  Created by  Sasha Khomenko on 03.04.2023.
//

import UIKit

class LoginView: UIView {
    
    // MARK: Outlets
    
    // Labels
    
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
    
    private(set) var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.backgroundColor = UIColor(named: "lightGreen")
        button.titleLabel?.font = UIFont(name: "Gill Sans SemiBold", size: 20)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        return button
    }()
    
    private(set) var registrationButton: UIButton = {
        let button = Utilities().attributedButton("Don't have an account?", " Sign Up")
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
    private(set) var emailTextField: UITextField = {
        let textField = Utilities().textField(withPlaceholder: "Email")
        textField.autocapitalizationType = .none
        textField.returnKeyType = .continue
        return textField
    }()
    
    private(set) var passwordTextField: UITextField = {
        let textField = Utilities().textField(withPlaceholder: "Password")
        textField.isSecureTextEntry = true
        textField.autocapitalizationType = .none
        textField.returnKeyType = .done
        return textField
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup UI
    private func setupUI() {
        let stackMain = UIStackView(arrangedSubviews: [welcomeLabel, adviceLabel, emailContainer, passwordContainer, forgotPassButton, loginButton,  registrationButton])
        stackMain.translatesAutoresizingMaskIntoConstraints = false
        stackMain.axis = .vertical
        stackMain.spacing = 15
        
        addSubview(stackMain)
        NSLayoutConstraint.activate([
            stackMain.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            stackMain.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            stackMain.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            emailTextField.heightAnchor.constraint(equalToConstant: 40),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            loginButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
