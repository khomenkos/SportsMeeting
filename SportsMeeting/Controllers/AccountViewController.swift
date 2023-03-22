//
//  AccountViewController.swift
//  SportsMeeting
//
//  Created by  Sasha Khomenko on 27.02.2023.
//

import UIKit
import SDWebImage
import FirebaseAuth

class AccountViewController: UIViewController {
    let scrollView = UIScrollView()

    private var user: User? {
        didSet { configure() }
    }
    
    private let image: UIImageView = {
        let imageView = UIImageView()
        imageView.setDimensions(width: 120, height: 120)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 4
        imageView.layer.cornerRadius = 120 / 2
        return imageView
    }()
    
    // Labels
    private let fullNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Galvji Bold", size: 22)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    private let dayOfBirthLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Galvji Bold", size: 15)
        label.textAlignment = .right
        label.textColor = .gray
        return label
    }()
    
    private let genderLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Galvji Bold", size: 15)
        label.textAlignment = .right
        label.textColor = .gray
        return label
    }()
    
    private let phoneLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Galvji Bold", size: 15)
        label.textAlignment = .right
        label.textColor = .gray
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Galvji Bold", size: 15)
        label.textAlignment = .right
        label.textColor = .gray
        return label
    }()
    
    // MARK: Containers
    
    //Info Stack
    private lazy var emailContainer: UIStackView = {
        let stack = Utilities().containerView(withlabel: "Email", view: emailLabel)
        stack.axis = .horizontal
        stack.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.backgroundColor = .white
        stack.cornerRadius = 15
        return stack
    }()
    
    private lazy var phoneContainer: UIStackView = {
        let stack = Utilities().containerView(withlabel: "Phone number", view: phoneLabel)
        stack.axis = .horizontal
        stack.backgroundColor = .white
        stack.cornerRadius = 15
        stack.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        stack.isLayoutMarginsRelativeArrangement = true
        return stack
    }()
    
    private lazy var genderContainer: UIStackView = {
        let stack = Utilities().containerView(withlabel: "Gender", view: genderLabel)
        stack.axis = .horizontal
        stack.backgroundColor = .white
        stack.cornerRadius = 15
        stack.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        stack.isLayoutMarginsRelativeArrangement = true
        return stack
    }()
    
    private lazy var dobContainer: UIStackView = {
        let stack = Utilities().containerView(withlabel: "Day of birth", view: dayOfBirthLabel)
        stack.axis = .horizontal
        stack.backgroundColor = .white
        stack.cornerRadius = 15
        stack.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        stack.isLayoutMarginsRelativeArrangement = true
        return stack
    }()
    
    //Setting Stack
    private lazy var editProfileContainer: UIStackView = {
        let imageView = UIImageView()
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "slider.vertical.3")
        imageView.setDimensions(width: 25, height: 40)
        let stack = Utilities().imageContainerView(withImage: imageView, textField: editProfileButton)
        stack.backgroundColor = .gray
        stack.cornerRadius = 15
        stack.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        stack.isLayoutMarginsRelativeArrangement = true
        return stack
    }()
    
    private lazy var helpContainer: UIStackView = {
        let imageView = UIImageView()
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "questionmark")
        imageView.setDimensions(width: 25, height: 40)
        let stack = Utilities().imageContainerView(withImage: imageView, textField: helpButton)
        stack.backgroundColor = .gray
        stack.cornerRadius = 15
        stack.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        stack.isLayoutMarginsRelativeArrangement = true
        return stack
    }()
    
    private lazy var aboutAppContainer: UIStackView = {
        let imageView = UIImageView()
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "info.circle")
        imageView.setDimensions(width: 25, height: 40)
        let stack = Utilities().imageContainerView(withImage: imageView, textField: aboutAppButton)
        stack.backgroundColor = .gray
        stack.cornerRadius = 15
        stack.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        stack.isLayoutMarginsRelativeArrangement = true
        return stack
    }()

    private let infoStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    private let settingStack: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .white
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.cornerRadius = 15
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    // Buttons
    private lazy var logOutButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(logOutBtn), for: .touchUpInside)
        button.setTitle("Log Out", for: .normal)
        button.backgroundColor = UIColor(named: "darkBlue")
        button.titleLabel?.font = UIFont(name: "Gill Sans SemiBold", size: 17)
        button.layer.cornerRadius = 15
        return button
    }()
    
    private lazy var editProfileButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(testBtn), for: .touchUpInside)
        button.setTitle("Edit Profile", for: .normal)
        button.titleLabel?.font = UIFont(name: "Galvji Bold", size: 17)
        button.contentVerticalAlignment = .center
        button.contentHorizontalAlignment = .left
        return button
    }()
    
    private lazy var helpButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(testBtn), for: .touchUpInside)
        button.setTitle("Help", for: .normal)
        button.titleLabel?.font = UIFont(name: "Galvji Bold", size: 17)
        button.contentVerticalAlignment = .center
        button.contentHorizontalAlignment = .left
        return button
    }()
    
    private lazy var aboutAppButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(testBtn), for: .touchUpInside)
        button.setTitle("About App", for: .normal)
        button.titleLabel?.font = UIFont(name: "Galvji Bold", size: 17)
        button.contentVerticalAlignment = .center
        button.contentHorizontalAlignment = .left
        return button
    }()
    
    // MARK: VC Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My Account"
        view.backgroundColor = UIColor(named: "lightGray")
        setupUI()
        loadData()
    }
    
    // MARK: Actions
    @objc private func logOutBtn() {
        showConfirmationAlert(withTitle: "Log Out", message: "Are you sure you want to log out?", confirmationHandler: {
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
        })
    }
    
    @objc private func testBtn() {
        
    }
    
    // MARK: Helpers
    private func configure() {
        guard let user = user else { return }
        image.sd_setImage(with: user.profileImageUrl) 
        fullNameLabel.text = user.firstName + " " + user.lastName
        dayOfBirthLabel.text = user.dayOfBirth
        genderLabel.text = user.gender
        phoneLabel.text = user.phoneNumber
        emailLabel.text = user.email
    }
    
    func loadData() {
        guard let uid = Auth.auth().currentUser?.uid else {
            print("User not logged in")
            return
        }
        DatabaseManager.shared.fetchUser(uid: uid) { user in
            self.user = user
        }
    }
        
    // MARK: Setting UI
    private func setupUI(){
        let stackMain = UIStackView()
        stackMain.translatesAutoresizingMaskIntoConstraints = false
        stackMain.axis = .vertical
        stackMain.spacing = 30
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(image)
        scrollView.addSubview(stackMain)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        stackMain.addArrangedSubview(fullNameLabel)
        stackMain.addArrangedSubview(infoStack)
        stackMain.addArrangedSubview(settingStack)
        stackMain.addArrangedSubview(logOutButton)
        
        infoStack.addArrangedSubview(emailContainer)
        infoStack.addArrangedSubview(phoneContainer)
        infoStack.addArrangedSubview(genderContainer)
        infoStack.addArrangedSubview(dobContainer)

        settingStack.addArrangedSubview(editProfileContainer)
        settingStack.addArrangedSubview(helpContainer)
        settingStack.addArrangedSubview(aboutAppContainer)

        NSLayoutConstraint.activate([
            
            image.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 25),
            image.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            stackMain.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 16),
            stackMain.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            stackMain.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            stackMain.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16),
            stackMain.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40),
            
            fullNameLabel.heightAnchor.constraint(equalToConstant: 30),
            dayOfBirthLabel.heightAnchor.constraint(equalToConstant: 50),
            genderLabel.heightAnchor.constraint(equalToConstant: 50),
            phoneLabel.heightAnchor.constraint(equalToConstant: 50),
            emailLabel.heightAnchor.constraint(equalToConstant: 50),
            
            editProfileContainer.heightAnchor.constraint(equalToConstant: 50),
            helpContainer.heightAnchor.constraint(equalToConstant: 50),
            aboutAppContainer.heightAnchor.constraint(equalToConstant: 50),
            logOutButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
