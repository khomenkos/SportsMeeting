//
//  RegistrationViewController.swift
//  SportsMeeting
//
//  Created by  Sasha Khomenko on 27.02.2023.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    // MARK: - Variables
    var activeTextField : UITextField? = nil
    
    // MARK: View
    private var views = RegistrationView()
    
    // MARK: Lifecycle
    override func loadView() {
        view = views
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupKeyboard()
        setupEventHandlers()
        setupDelegates()
    }
    
    // MARK: Actions
    private func setupEventHandlers() {
        views.registrationButton.addTarget(self, action: #selector(registrationButtonTapped), for: .touchUpInside)
        views.loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        views.plusPhotoButton.addTarget(self, action: #selector(addProfilePhotoBtn), for: .touchUpInside)
    }
    
    private func setupDelegates() {
        views.passwordTextField.delegate = self
        views.confirmPassTextField.delegate = self
        views.imagePicker.delegate = self
        views.imagePicker.allowsEditing = true
    }
    
    @objc func addProfilePhotoBtn() {
        present(views.imagePicker, animated: true, completion: nil)
    }
    
    @objc func loginButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func registrationButtonTapped() {
        guard let profileImage = views.profileImage else {
            self.showAlert(withTitle: "Registration Error", message: "Please select a profile image.")
            return
        }
        
        guard let firstName = views.nameTextField.text, !firstName.isEmpty,
              let lastName = views.lastNameTextField.text, !lastName.isEmpty,
              let phoneNumber = views.phoneTextField.text, !phoneNumber.isEmpty,
              let email = views.emailTextField.text, !email.isEmpty,
              let password = views.passwordTextField.text, !password.isEmpty, password.count >= 8,
              let confirmPass = views.confirmPassTextField.text, !confirmPass.isEmpty,
              password == confirmPass else {
            showAlert(withTitle: "Registration Error", message: "Check the data is correct and try again")
            return
        }
        
        let genderIndex = views.segmentedControl.selectedSegmentIndex
        let gender = genderIndex == 0 ? "Male" : "Female"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        
        let birthday = dateFormatter.string(from: views.datePicker.date)
        
        AuthManager.shared.registerNewUser(firstName: firstName,
                                           lastName: lastName,
                                           dayOfBirth: birthday,
                                           gender: gender,
                                           phoneNumber: phoneNumber,
                                           email: email,
                                           password: password,
                                           profileImage: profileImage){ registered in
            DispatchQueue.main.async {
                if registered {
                    let vc = TabBarViewController()
                    vc.modalPresentationStyle = .overFullScreen
                    self.present(vc, animated: true)
                } else {
                    self.showAlert(withTitle: "Registration Error", message: "Check the data is correct and try again")
                }
            }
        }
    }
    
    // MARK: Setup Keyboard
    private func setupKeyboard() {
        hideKeyboard()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
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

extension RegistrationViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeTextField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.activeTextField = nil
    }
}

extension RegistrationViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let profileImage = info[.editedImage] as? UIImage else { return }
        self.views.profileImage = profileImage
        
        views.plusPhotoButton.layer.cornerRadius = 128 / 2
        views.plusPhotoButton.layer.masksToBounds = true
        views.plusPhotoButton.imageView?.contentMode = .scaleAspectFill
        views.plusPhotoButton.imageView?.clipsToBounds = true
        views.plusPhotoButton.layer.borderColor = UIColor.black.cgColor
        views.plusPhotoButton.layer.borderWidth = 3
        
        self.views.plusPhotoButton.setImage(profileImage.withRenderingMode(.alwaysOriginal), for: .normal)
        
        dismiss(animated: true, completion: nil)
    }
}
