//
//  SignUpViewController.swift
//  SportsMeeting
//
//  Created by  Sasha Khomenko on 27.02.2023.
//

import UIKit


class SignUpViewController: UIViewController {
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    var activeTextField : UITextField? = nil
    
    // MARK: Outlets
    
    //Labels
    private let signUpLabel: UILabel = {
        let label = UILabel()
        label.text = "SignUp"
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
    
    private let firstNameLabel: UILabel = {
        let label = UILabel()
        label.text = "First Name"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Gill Sans SemiBold", size: 17)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private let lastNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Last Name"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Gill Sans SemiBold", size: 17)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private let dayOfBirthLabel: UILabel = {
        let label = UILabel()
        label.text = "Day Of Birth"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Gill Sans SemiBold", size: 17)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let genderLabel: UILabel = {
        let label = UILabel()
        label.text = "Gender"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Gill Sans SemiBold", size: 17)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private let phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "Phone Number"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Gill Sans SemiBold", size: 17)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Gill Sans SemiBold", size: 17)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Password"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Gill Sans SemiBold", size: 17)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private let confirmPassLabel: UILabel = {
        let label = UILabel()
        label.text = "Confirm Password"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Gill Sans SemiBold", size: 17)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private let loginLabel: UILabel = {
        let label = UILabel()
        label.text = "Already have an account?"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Gill Sans Light", size: 18)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .lightGray
        return label
    }()
    
    // Date Picker
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.contentHorizontalAlignment = .center
        datePicker.contentVerticalAlignment = .center
        return datePicker
    }()
    
    // Segmented Control
    private lazy var segmentedControl: UISegmentedControl = {
        let items = ["Male", "Female"]
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
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
    
    private let stackName: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    private let stackFirstName: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    private let stackLastName: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    private let stackDayOfBirth: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.layer.cornerRadius = 5
        stackView.layer.borderWidth = 0.1
        stackView.layer.borderColor = UIColor.black.cgColor
        return stackView
    }()
    
    private let stackGender: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    private let stackPhoneNum: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    private let stackEmail: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    private let stackPassword: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    private let stackConfirmPass: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    
    private let stackLogin: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        return stackView
    }()
    
    // Buttons
    private lazy var registerButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(sighUpBtn), for: .touchUpInside)
        button.setTitle("Register", for: .normal)
        button.backgroundColor = UIColor(named: "lightRed")
        button.titleLabel?.font = UIFont(name: "Gill Sans SemiBold", size: 20)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        return button
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(loginBtn), for: .touchUpInside)
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.link, for: .normal)
        button.titleLabel?.font = UIFont(name: "Gill Sans SemiBold", size: 16)
        
        return button
    }()
    
    // Text Field
    
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Calvin"
        textField.borderStyle = .roundedRect
        textField.autocorrectionType = .no
        textField.returnKeyType = .continue
        textField.backgroundColor = .secondarySystemBackground
        return textField
    }()
    
    private lazy var lastNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Klein"
        textField.borderStyle = .roundedRect
        textField.autocorrectionType = .no
        textField.returnKeyType = .continue
        textField.backgroundColor = .secondarySystemBackground
        return textField
    }()
    
    private lazy var phoneTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "+380..."
        textField.borderStyle = .roundedRect
        textField.keyboardType = .phonePad
        textField.autocorrectionType = .no
        textField.returnKeyType = .continue
        textField.backgroundColor = .secondarySystemBackground
        return textField
    }()
    
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
        textField.returnKeyType = .continue
        textField.backgroundColor = .secondarySystemBackground
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private lazy var confirmPassTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Confirm Password"
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.returnKeyType = .done
        textField.backgroundColor = .secondarySystemBackground
        textField.isSecureTextEntry = true
        return textField
    }()
    
    // MARK: VC Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        nameTextField.delegate = self
        lastNameTextField.delegate = self
        emailTextField.delegate = self
        phoneTextField.delegate = self
        passwordTextField.delegate = self
        confirmPassTextField.delegate = self
        
        setupScrollView()
        setupViews()
        setupKeyboard()
        
    }
    
    // MARK: Actions
    @objc func loginBtn() {
        let loginVC = SignInViewController()
        loginVC.modalPresentationStyle = .overFullScreen
        present(loginVC, animated: true, completion: nil)
    }
    
    @objc func sighUpBtn() {
        guard let firstName = nameTextField.text, !firstName.isEmpty,
              let lastName = lastNameTextField.text, !lastName.isEmpty,
              let phoneNumber = phoneTextField.text, !phoneNumber.isEmpty,
              let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty, password.count >= 8,
              let confirmPass = confirmPassTextField.text, !confirmPass.isEmpty,
              password == confirmPass else {
            alertError()
            return
        }
        
        let genderIndex = segmentedControl.selectedSegmentIndex
        let gender = genderIndex == 0 ? "Male" : "Female"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        
        let birthday = dateFormatter.string(from: datePicker.date)
        
        AuthManager.shared.registerNewUser(firstName: firstName,
                                           lastName: lastName,
                                           dayOfBirth: birthday,
                                           gender: gender,
                                           phoneNumber: phoneNumber,
                                           email: email,
                                           password: password){ registered in
            DispatchQueue.main.async {
                if registered {
                    let vc = TabBarViewController()
                    vc.modalPresentationStyle = .overFullScreen
                    self.present(vc, animated: true)
                } else {
                    self.alertError()
                }
            }
        }
    }
    
    private func alertError() {
        let alert = UIAlertController(title: "Register Error",
                                      message: "We were unable to log you in.",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss",
                                      style: .cancel,
                                      handler: nil))
        present(alert, animated: true)
    }
    
    // MARK: Setting Keyboard
    
    private func setupKeyboard() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(backgroundTap))
        view.addGestureRecognizer(tapGestureRecognizer)
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            // if keyboard size is not available for some reason, dont do anything
            return
        }
        var shouldMoveViewUp = false
        
        // if active text field is not nil
        if let activeTextField = activeTextField {
            
            let bottomOfTextField = activeTextField.convert(activeTextField.bounds, to: self.contentView).maxY;
            let topOfKeyboard = self.contentView.frame.height - keyboardSize.height
            
            if bottomOfTextField > topOfKeyboard {
                shouldMoveViewUp = true
            }
        }
        
        if(shouldMoveViewUp) {
            self.contentView.frame.origin.y = 0 - keyboardSize.height
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.contentView.frame.origin.y = 0
    }
    
    @objc func backgroundTap(_ sender: UITapGestureRecognizer) {
        // go through all of the textfield inside the view, and end editing thus resigning first responder
        // ie. it will trigger a keyboardWillHide notification
        self.contentView.endEditing(true)
    }
    
    // MARK: Constraints
    
    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        // Hide keyboard while scrolling
        scrollView.keyboardDismissMode = .onDrag
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }
    
    private func setupViews(){
        contentView.addSubview(signUpLabel)
        NSLayoutConstraint.activate([
            signUpLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            signUpLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
        
        contentView.addSubview(adviceLabel)
        NSLayoutConstraint.activate([
            adviceLabel.topAnchor.constraint(equalTo: signUpLabel.bottomAnchor, constant: 10),
            adviceLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        ])
        
        contentView.addSubview(stackMain)
        stackMain.addArrangedSubview(stackName)
        stackMain.addArrangedSubview(stackFirstName)
        stackMain.addArrangedSubview(stackLastName)
        stackMain.addArrangedSubview(stackDayOfBirth)
        stackMain.addArrangedSubview(stackGender)
        stackMain.addArrangedSubview(stackPhoneNum)
        stackMain.addArrangedSubview(stackEmail)
        stackMain.addArrangedSubview(stackPassword)
        stackMain.addArrangedSubview(stackConfirmPass)
        stackMain.addArrangedSubview(registerButton)
        
        stackName.addArrangedSubview(stackFirstName)
        stackName.addArrangedSubview(stackLastName)
        
        stackFirstName.addArrangedSubview(firstNameLabel)
        stackFirstName.addArrangedSubview(nameTextField)
        
        stackLastName.addArrangedSubview(lastNameLabel)
        stackLastName.addArrangedSubview(lastNameTextField)
        
        stackDayOfBirth.addArrangedSubview(dayOfBirthLabel)
        stackDayOfBirth.addArrangedSubview(datePicker)
        
        stackGender.addArrangedSubview(genderLabel)
        stackGender.addArrangedSubview(segmentedControl)
        
        stackPhoneNum.addArrangedSubview(phoneNumberLabel)
        stackPhoneNum.addArrangedSubview(phoneTextField)
        
        stackEmail.addArrangedSubview(emailLabel)
        stackEmail.addArrangedSubview(emailTextField)
        
        stackPassword.addArrangedSubview(passwordLabel)
        stackPassword.addArrangedSubview(passwordTextField)
        
        stackConfirmPass.addArrangedSubview(confirmPassLabel)
        stackConfirmPass.addArrangedSubview(confirmPassTextField)
        
        NSLayoutConstraint.activate([
            stackMain.topAnchor.constraint(equalTo: adviceLabel.bottomAnchor, constant: 25),
            stackMain.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            stackMain.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            nameTextField.heightAnchor.constraint(equalToConstant: 50),
            lastNameTextField.heightAnchor.constraint(equalToConstant: 50),
            stackDayOfBirth.heightAnchor.constraint(equalToConstant: 50),
            segmentedControl.heightAnchor.constraint(equalToConstant: 35),
            phoneTextField.heightAnchor.constraint(equalToConstant: 50),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            confirmPassTextField.heightAnchor.constraint(equalToConstant: 50),
            registerButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        contentView.addSubview(stackLogin)
        stackLogin.addArrangedSubview(loginLabel)
        stackLogin.addArrangedSubview(loginButton)
        
        NSLayoutConstraint.activate([
            stackLogin.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            stackLogin.topAnchor.constraint(equalTo: stackMain.bottomAnchor, constant: 8),
            stackLogin.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            emailTextField.becomeFirstResponder()
        } else if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else {
            sighUpBtn()
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeTextField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.activeTextField = nil
    }
}


