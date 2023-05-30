//
//  RegistrationView.swift
//  SportsMeeting
//
//  Created by  Sasha Khomenko on 03.04.2023.
//

import UIKit

class RegistrationView: UIView {
    
    // MARK: Outlets
    
    //ScrollView
    private let scrollView = UIScrollView()
    
    //Image
    private(set) var imagePicker = UIImagePickerController()
    var profileImage: UIImage?
    
    //Labels
    private let registrationLabel: UILabel = {
        let label = UILabel()
        label.text = "SignUp"
        label.font = UIFont(name: "Gill Sans SemiBold", size: 33)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let adviceLabel: UILabel = {
        let label = UILabel()
        label.text = "Please enter your email address and enter password"
        label.font = UIFont(name: "Gill Sans Light", size: 16)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Date Picker
    private(set) var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.contentHorizontalAlignment = .right
        datePicker.contentVerticalAlignment = .center
        return datePicker
    }()
    
    // Segmented Control
    private(set) var segmentedControl: UISegmentedControl = {
        let items = ["Male", "Female"]
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()
    
    // Containers
    private lazy var firstNameContainer: UIStackView = {
        let stack = Utilities().containerView(withlabel: "First Name", view: nameTextField)
        return stack
    }()
    
    private lazy var lastNameContainer: UIStackView = {
        let stack = Utilities().containerView(withlabel: "Last Name", view: lastNameTextField)
        return stack
    }()
    
    private lazy var dobContainer: UIStackView = {
        let stack = Utilities().containerView(withlabel: "Day Of Birth", view: datePicker)
        stack.axis = .horizontal
        return stack
    }()
    
    private lazy var genderContainer: UIStackView = {
        let stack = Utilities().containerView(withlabel: "Gender", view: segmentedControl)
        return stack
    }()
    
    private lazy var phoneNumberContainer: UIStackView = {
        let stack = Utilities().containerView(withlabel: "Telegram/Viber/WhatsApp", view: phoneTextField)
        return stack
    }()
    
    private lazy var emailContainer: UIStackView = {
        let stack = Utilities().containerView(withlabel: "Email", view: emailTextField)
        return stack
    }()
    
    private lazy var passwordContainer: UIStackView = {
        let stack = Utilities().containerView(withlabel: "Password", view: passwordTextField)
        return stack
    }()
    
    private lazy var confirmPassContainer: UIStackView = {
        let stack = Utilities().containerView(withlabel: "Confirm Password", view: confirmPassTextField)
        return stack
    }()
    
    // Text Fields
    private(set) var nameTextField: UITextField = {
        let textField = Utilities().textField(withPlaceholder: "First Name")
        textField.returnKeyType = .continue
        return textField
    }()
    
    private(set) var lastNameTextField: UITextField = {
        let textField = Utilities().textField(withPlaceholder: "Last Name")
        textField.returnKeyType = .continue
        return textField
    }()
    
    private(set) var phoneTextField: UITextField = {
        let textField = Utilities().textField(withPlaceholder: "Username/PhoneNumber")
        textField.returnKeyType = .continue
        return textField
    }()
    
    private(set) var emailTextField: UITextField = {
        let textField = Utilities().textField(withPlaceholder: "Email")
        textField.returnKeyType = .continue
        textField.autocapitalizationType = .none
        return textField
    }()
    
    private(set) var passwordTextField: UITextField = {
        let textField = Utilities().textField(withPlaceholder: "Password")
        textField.returnKeyType = .continue
        textField.autocapitalizationType = .none
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private(set) var confirmPassTextField: UITextField = {
        let textField = Utilities().textField(withPlaceholder: "Confirm Password")
        textField.returnKeyType = .done
        textField.autocapitalizationType = .none
        textField.isSecureTextEntry = true
        return textField
    }()
    
    // Buttons
    private(set) var registrationButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.backgroundColor = UIColor(named: "lightRed")
        button.titleLabel?.font = UIFont(name: "Gill Sans SemiBold", size: 20)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        return button
    }()
    
    private(set) var loginButton: UIButton = {
        let button = Utilities().attributedButton("Already have an account?", " Log In")
        return button
    }()
    
    private(set) var plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .black
        button.setDimensions(width: 128, height: 128)
        button.layer.cornerRadius = 128 / 2
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 3
        
        return button
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
    private func setupUI(){
        let stackMain = UIStackView(arrangedSubviews: [firstNameContainer, lastNameContainer, dobContainer, segmentedControl, phoneNumberContainer, emailContainer, passwordContainer, confirmPassContainer, registrationButton, loginButton])
        stackMain.translatesAutoresizingMaskIntoConstraints = false
        stackMain.axis = .vertical
        stackMain.spacing = 20
        
        scrollView.keyboardDismissMode = .onDrag
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(scrollView)
        scrollView.addSubview(registrationLabel)
        scrollView.addSubview(adviceLabel)
        scrollView.addSubview(plusPhotoButton)
        scrollView.addSubview(stackMain)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            registrationLabel.topAnchor.constraint(equalTo: scrollView.topAnchor),
            registrationLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            adviceLabel.topAnchor.constraint(equalTo: registrationLabel.bottomAnchor, constant: 10),
            adviceLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            plusPhotoButton.topAnchor.constraint(equalTo: adviceLabel.bottomAnchor, constant: 10),
            plusPhotoButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            stackMain.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            stackMain.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            stackMain.topAnchor.constraint(equalTo: plusPhotoButton.bottomAnchor, constant: 16),
            stackMain.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            nameTextField.heightAnchor.constraint(equalToConstant: 50),
            lastNameTextField.heightAnchor.constraint(equalToConstant: 50),
            segmentedControl.heightAnchor.constraint(equalToConstant: 35),
            phoneTextField.heightAnchor.constraint(equalToConstant: 50),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            confirmPassTextField.heightAnchor.constraint(equalToConstant: 50),
            registrationButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
