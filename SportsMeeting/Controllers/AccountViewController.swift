//
//  AccountViewController.swift
//  SportsMeeting
//
//  Created by  Sasha Khomenko on 27.02.2023.
//

import UIKit
import Firebase

class AccountViewController: UIViewController {
    
    private let image: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "manImage")
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        //imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let firstNameLabel: UILabel = {
        let label = UILabel()
        label.text = "First Name"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Gill Sans Light", size: 17)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let lastNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Last Name"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Gill Sans Light", size: 17)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let dayOfBirthLabel: UILabel = {
        let label = UILabel()
        label.text = "Day Of Birth"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Gill Sans Light", size: 17)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let genderLabel: UILabel = {
        let label = UILabel()
        label.text = "Gender"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Gill Sans Light", size: 17)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "Phone Number"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Gill Sans Light", size: 17)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    // Title
    
    private let firstNameTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Gill Sans SemiBold", size: 22)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    private let lastNameTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Gill Sans SemiBold", size: 22)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    private let dayOfBirthTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Gill Sans SemiBold", size: 22)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    private let genderTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Gill Sans SemiBold", size: 22)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    private let phoneTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Gill Sans SemiBold", size: 22)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .black
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
        stackView.layer.cornerRadius = 5
        //stackView.layer.borderWidth = 1
        stackView.layer.borderColor = UIColor.black.cgColor
        return stackView
    }()
    
    private let stackLastName: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.layer.cornerRadius = 5
        //stackView.layer.borderWidth = 1
        stackView.layer.borderColor = UIColor.black.cgColor
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
        stackView.layer.borderWidth = 1
        stackView.layer.borderColor = UIColor.black.cgColor
        return stackView
    }()
    
    private let stackGender: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.layer.cornerRadius = 5
        stackView.layer.borderWidth = 1
        stackView.layer.borderColor = UIColor.black.cgColor
        return stackView
    }()
    
    private let stackPhoneNum: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.layer.cornerRadius = 5
        stackView.layer.borderWidth = 1
        stackView.layer.borderColor = UIColor.black.cgColor
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "My Account"
        view.backgroundColor = .systemBackground
        setupBarItem()
        
        setupViews()
        
        loadData()
    }
            
    func loadData() {
        guard let email = Auth.auth().currentUser?.email else {
            print("User not logged in")
            return
        }
        
        DatabaseManager.shared.getUserData(email: email) { (userData, error) in
            if let error = error {
                
                print("Error loading user data: \(error.localizedDescription)")
                return
            }
            guard let userData = userData else {
                print("User data not found")
                return
            }
            self.firstNameTitle.text = userData["firstName"] as? String
            self.lastNameTitle.text = userData["lastName"] as? String
            self.dayOfBirthTitle.text = userData["dayOfBirth"] as? String
            self.genderTitle.text = userData["gender"] as? String
            self.phoneTitle.text = userData["phoneNumber"] as? String
        }
    }
                
    private func setupBarItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"),
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapSettingsButton))
    }
    
    @objc private func didTapSettingsButton() {
        let actionSheet = UIAlertController(title: "Log Out",
                                            message: "Are you sure you want to log out?",
                                            preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Cancel",
                                            style: .cancel, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { _ in
            AuthManager.shared.logOut(completion: { success in
                DispatchQueue.main.async {
                    if success {
                        // Present log in
                        let loginVC = SignInViewController()
                        loginVC.modalPresentationStyle = .fullScreen
                        self.present(loginVC, animated: true) {
                            self.navigationController?.popToRootViewController(animated: false)
                            self.tabBarController?.selectedIndex = 0
                        }
                    } else {
                        // Error occurred
                        fatalError("Could not log out user")
                    }
                }
            })
        }))
    
        present(actionSheet, animated: true)
    }
    
    private func setupViews(){
        view.addSubview(image)
        view.addSubview(stackMain)
        stackMain.addArrangedSubview(stackName)
        stackMain.addArrangedSubview(stackFirstName)
        stackMain.addArrangedSubview(stackLastName)
        stackMain.addArrangedSubview(stackDayOfBirth)
        stackMain.addArrangedSubview(stackGender)
        stackMain.addArrangedSubview(stackPhoneNum)
        
        stackName.addArrangedSubview(stackFirstName)
        stackName.addArrangedSubview(stackLastName)
        
        stackFirstName.addArrangedSubview(firstNameLabel)
        stackFirstName.addArrangedSubview(firstNameTitle)
        
        stackLastName.addArrangedSubview(lastNameLabel)
        stackLastName.addArrangedSubview(lastNameTitle)
        
        stackDayOfBirth.addArrangedSubview(dayOfBirthLabel)
        stackDayOfBirth.addArrangedSubview(dayOfBirthTitle)
        
        stackGender.addArrangedSubview(genderLabel)
        stackGender.addArrangedSubview(genderTitle)
        
        stackPhoneNum.addArrangedSubview(phoneNumberLabel)
        stackPhoneNum.addArrangedSubview(phoneTitle)
        
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            image.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            stackMain.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 10),
            stackMain.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            stackMain.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            //stackMain.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),

            image.heightAnchor.constraint(equalToConstant: 100),
            image.widthAnchor.constraint(equalToConstant: 100),
            firstNameTitle.heightAnchor.constraint(equalToConstant: 20),
            lastNameTitle.heightAnchor.constraint(equalToConstant: 20),
            dayOfBirthTitle.heightAnchor.constraint(equalToConstant: 50),
            genderTitle.heightAnchor.constraint(equalToConstant: 50),
            phoneTitle.heightAnchor.constraint(equalToConstant: 50),
        ])

    }
}
