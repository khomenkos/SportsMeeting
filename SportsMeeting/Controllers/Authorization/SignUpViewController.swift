//
//  SignUpViewController.swift
//  SportsMeeting
//
//  Created by  Sasha Khomenko on 27.02.2023.
//

import UIKit


class SignUpViewController: UIViewController {
    
    let scrollView = UIScrollView()
    var activeTextField : UITextField? = nil
    
    // MARK: Outlets
    
    //Labels
    private let signUpLabel: UILabel = {
        let label = UILabel()
        label.text = "SignUp"
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
    
    // Date Picker
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.contentHorizontalAlignment = .right
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
        let stack = Utilities().containerView(withlabel: "Phone Number", view: phoneTextField)
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
    private lazy var nameTextField: UITextField = {
        let textField = Utilities().textField(withPlaceholder: "First Name")
        textField.delegate = self
        textField.returnKeyType = .continue
        return textField
    }()
    
    private lazy var lastNameTextField: UITextField = {
        let textField = Utilities().textField(withPlaceholder: "Last Name")
        textField.delegate = self
        textField.returnKeyType = .continue
        return textField
    }()
    
    private lazy var phoneTextField: UITextField = {
        let textField = Utilities().textField(withPlaceholder: "+380...")
        textField.delegate = self
        textField.returnKeyType = .continue
        textField.keyboardType = .phonePad
        return textField
    }()
    
    private lazy var emailTextField: UITextField = {
        let textField = Utilities().textField(withPlaceholder: "Email")
        textField.delegate = self
        textField.returnKeyType = .continue
        textField.autocapitalizationType = .none
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = Utilities().textField(withPlaceholder: "Password")
        textField.delegate = self
        textField.returnKeyType = .continue
        textField.autocapitalizationType = .none
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private lazy var confirmPassTextField: UITextField = {
        let textField = Utilities().textField(withPlaceholder: "Confirm Password")
        textField.delegate = self
        textField.returnKeyType = .done
        textField.autocapitalizationType = .none
        textField.isSecureTextEntry = true
        return textField
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
        let button = Utilities().attributedButton("Already have an account?", " Log In")
        button.addTarget(self, action: #selector(loginBtn), for: .touchUpInside)
        return button
    }()
    
    // MARK: VC Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
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
            showAlert(withTitle: "Log In Error", message: "We were unable to log you in.")
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
                    self.showAlert(withTitle: "Register Error", message: "We were unable to log you in.")
                }
            }
        }
    }
    
    // MARK: Setting UI
    private func setupUI(){
        let stackMain = UIStackView(arrangedSubviews: [signUpLabel, adviceLabel, firstNameContainer, lastNameContainer, dobContainer, segmentedControl, phoneNumberContainer, emailContainer, passwordContainer, confirmPassContainer, registerButton, loginButton])
        stackMain.translatesAutoresizingMaskIntoConstraints = false
        stackMain.axis = .vertical
        stackMain.spacing = 20
        
        scrollView.keyboardDismissMode = .onDrag
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(stackMain)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            stackMain.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            stackMain.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            stackMain.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            stackMain.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16),
            stackMain.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40)
        ])
        
        NSLayoutConstraint.activate([
            nameTextField.heightAnchor.constraint(equalToConstant: 50),
            lastNameTextField.heightAnchor.constraint(equalToConstant: 50),
            segmentedControl.heightAnchor.constraint(equalToConstant: 35),
            phoneTextField.heightAnchor.constraint(equalToConstant: 50),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            confirmPassTextField.heightAnchor.constraint(equalToConstant: 50),
            registerButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    // MARK: Setting Keyboard
    private func setupKeyboard() {
        hideKeyboard()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        var shouldMoveViewUp = false
        
        if let activeTextField = activeTextField {
            
            let bottomOfTextField = activeTextField.convert(activeTextField.bounds, to: self.view).maxY;
            let topOfKeyboard = self.view.frame.height - keyboardSize.height
            
            if bottomOfTextField > topOfKeyboard {
                shouldMoveViewUp = true
            }
        }
        
        if(shouldMoveViewUp) {
            self.view.frame.origin.y = 0 - keyboardSize.height
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }
}

extension SignUpViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeTextField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.activeTextField = nil
    }
}
