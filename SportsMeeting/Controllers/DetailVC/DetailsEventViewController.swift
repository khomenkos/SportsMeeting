//
//  DetailEventViewController.swift
//  SportsMeeting
//
//  Created by  Sasha Khomenko on 07.03.2023.
//

import UIKit
import FirebaseAuth

class DetailsEventViewController: UIViewController {
    
    var event: Event!
    let scrollView = UIScrollView()
    weak var delegate: ProfileViewControllerDelegate?

    //MARK: Outlets
    
    // Images
    private lazy var headerImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "run")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var userImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 100 / 2
        imageView.setDimensions(width: 100, height: 100)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderWidth = 8
        imageView.layer.borderColor = UIColor(named: "lightGray")?.cgColor
        return imageView
    }()
    
    // Labels
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Gill Sans Light", size: 18)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Galvji Bold", size: 28)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var sportTypeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Galvji Bold", size: 17)
        label.textAlignment = .center
        label.layer.cornerRadius = 15
        label.backgroundColor = .white
        label.clipsToBounds = true
        label.numberOfLines = 2
        label.layer.borderWidth = 2
        label.layer.borderColor = UIColor.lightGray.cgColor
        return label
    }()
    
    private lazy var peopleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Galvji Bold", size: 15)
        label.textAlignment = .center
        label.layer.cornerRadius = 15
        label.backgroundColor = .white
        label.clipsToBounds = true
        label.numberOfLines = 3
        label.layer.borderWidth = 2
        label.layer.borderColor = UIColor.lightGray.cgColor
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Galvji Bold", size: 15)
        label.textAlignment = .center
        label.layer.cornerRadius = 15
        label.backgroundColor = .white
        label.clipsToBounds = true
        label.numberOfLines = 3
        label.layer.borderWidth = 2
        label.layer.borderColor = UIColor.lightGray.cgColor
        return label
    }()
    
    private lazy var locationTitle: UILabel = {
        let label = UILabel()
        label.text = "Location"
        label.font = UIFont(name: "Galvji", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Galvji Bold", size: 15)
        label.textAlignment = .center
        label.layer.cornerRadius = 10
        label.numberOfLines = 1
        label.layer.borderWidth = 2
        label.layer.borderColor = UIColor.lightGray.cgColor
        return label
    }()
    
    // Stacks
    private lazy var detailsStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .center
        stack.spacing = 10
        stack.alignment = .fill
        stack.distribution = .fillEqually
        return stack
    }()
    
    private lazy var stackMain: UIStackView = {
        let stackMain = UIStackView(arrangedSubviews: [titleLabel, detailsStack, locationTitle, locationLabel, openChatButton, deleteButton])
        stackMain.translatesAutoresizingMaskIntoConstraints = false
        stackMain.axis = .vertical
        stackMain.spacing = 20
        stackMain.layer.cornerRadius = 15
        stackMain.backgroundColor = UIColor(named: "lightGray")
        stackMain.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        stackMain.isLayoutMarginsRelativeArrangement = true
        //shadow
        stackMain.layer.masksToBounds = false
        stackMain.layer.shadowColor = UIColor.gray.cgColor
        stackMain.layer.shadowOpacity = 1
        stackMain.layer.shadowOffset = CGSize.zero
        stackMain.layer.shadowRadius = 3
        return stackMain
    }()
    
    // Buttons
    private lazy var openChatButton: UIButton = {
        let button = UIButton()
        button.setTitle("Open Chat", for: .normal)
        button.addTarget(self, action: #selector(openChatAction), for: .touchUpInside)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Gill Sans SemiBold", size: 16)
        button.layer.cornerRadius = 20
        button.backgroundColor = UIColor.customDarkBlue
        button.setDimensions(width: 300, height: 50)
        button.isHidden = false
        return button
    }()
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("Delete Event", for: .normal)
        button.addTarget(self, action: #selector(deleteEventAction), for: .touchUpInside)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Gill Sans SemiBold", size: 16)
        button.layer.cornerRadius = 20
        button.backgroundColor = UIColor.customRed
        button.setDimensions(width: 300, height: 50)
        button.isHidden = true
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setupUI()
    }
        
    @objc func openChatAction() {
        let username = event.user.phoneNumber
        
        let alertController = UIAlertController(title: "Open Chat", message: "Select an app", preferredStyle: .actionSheet)
        
        // Telegram
        if let telegramURL = URL(string: "tg://resolve?domain=\(username)") {
            print(telegramURL)
            let telegramAction = UIAlertAction(title: "Telegram", style: .default) { _ in
                UIApplication.shared.open(telegramURL, options: [:], completionHandler: nil)
            }
            alertController.addAction(telegramAction)
        }
        
        // Viber
        if let viberURL = URL(string: "viber://pa?chatURI=\(username)") {
            let viberAction = UIAlertAction(title: "Viber", style: .default) { _ in
                UIApplication.shared.open(viberURL, options: [:], completionHandler: nil)
            }
            alertController.addAction(viberAction)
        }
        
        // WhatsApp
        if let whatsappURL = URL(string: "whatsapp://send?phone=\(username)") {
            let whatsappAction = UIAlertAction(title: "WhatsApp", style: .default) { _ in
                UIApplication.shared.open(whatsappURL, options: [:], completionHandler: nil)
            }
            alertController.addAction(whatsappAction)
        }
        
        // Cancel action
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        // Present the action sheet
        if let popoverController = alertController.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = self.view.bounds
        }
        present(alertController, animated: true, completion: nil)
    }
    
    private func configure() {
        userImage.sd_setImage(with: event.user.profileImageUrl)
        authorLabel.text = event.user.fullName
        titleLabel.text = event.nameEvent
        sportTypeLabel.text = event.sportType
        peopleLabel.text = "Number of people:" + " " + event.comment
        dateLabel.text = event.dateTime
        locationLabel.text = event.location
        
        if event.user.uid == Auth.auth().currentUser?.uid {
            deleteButton.isHidden = false
            openChatButton.isHidden = true
        }
    }
    
    @objc private func deleteEventAction() {
        let alertController = UIAlertController(title: "Delete Event", message: "Are you sure you want to delete this event?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)

        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { _ in

            DatabaseManager.shared.deleteEvent(eventID: self.event.eventID) { success in
                if success {
                    if let navigationController = self.navigationController {
                        self.delegate?.didDeleteEvent(withID: self.event.eventID)
                        navigationController.popToRootViewController(animated: true)
                    } else {
                        self.delegate?.didDeleteEvent(withID: self.event.eventID)
                        self.dismiss(animated: true, completion: nil)
                    }
                
                } else {
                    DispatchQueue.main.async {
                        self.showAlert(withTitle: "Deletion error", message: "Please try again")
                    }
                }
            }
        }
        alertController.addAction(deleteAction)
        present(alertController, animated: true, completion: nil)
    }
    
    //MARK: Constraints
    private func setupUI(){
        view.backgroundColor = .systemBackground
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.addBlackGradientLayerInForeground(frame: view.bounds, colors: [.clear, .black])

        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        scrollView.addSubview(headerImage)
        NSLayoutConstraint.activate([
            headerImage.topAnchor.constraint(equalTo: scrollView.topAnchor),
            headerImage.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            headerImage.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor),
            headerImage.heightAnchor.constraint(equalToConstant: 200)
        ])

        scrollView.addSubview(userImage)
        NSLayoutConstraint.activate([
            userImage.topAnchor.constraint(equalTo: headerImage.bottomAnchor, constant: -45),
            userImage.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
        ])
        
        scrollView.addSubview(authorLabel)
        NSLayoutConstraint.activate([
            authorLabel.topAnchor.constraint(equalTo: userImage.bottomAnchor, constant: 3),
            authorLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        ])
        
        scrollView.addSubview(stackMain)
        detailsStack.addArrangedSubview(dateLabel)
        detailsStack.addArrangedSubview(sportTypeLabel)
        detailsStack.addArrangedSubview(peopleLabel)
        
        NSLayoutConstraint.activate([
            detailsStack.heightAnchor.constraint(equalToConstant: 75),
            locationLabel.heightAnchor.constraint(equalToConstant: 30),
            
            stackMain.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 10),
            stackMain.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10),
            stackMain.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            stackMain.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -15),
        ])
    }
}
