//
//  ProfileViewController.swift
//  SportsMeeting
//
//  Created by  Sasha Khomenko on 27.02.2023.
//

import UIKit
import SDWebImage
import FirebaseAuth

protocol ProfileViewControllerDelegate: AnyObject {
    func didDeleteEvent(withID eventID: String)
}

class ProfileViewController: UICollectionViewController {

    private var viewModel = ProfileViewModel()
    
        // Buttons
        private lazy var logOutButton: UIButton = {
            let button = UIButton()
            button.addTarget(self, action: #selector(logOutBtn), for: .touchUpInside)
            button.sizeSymbol(name: "rectangle.portrait.and.arrow.right", size: 20, weight: .light, scale: .medium)
            return button
        }()
    
    // MARK: VC Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        view.backgroundColor = UIColor(named: "lightGray")
        configureCollectionView()
        viewModel.delegate = self
        viewModel.loadData()
        setupNavBar()
    }

    func configureCollectionView() {
        collectionView.backgroundColor = .white
        collectionView.register(ProfileEventCell.self, forCellWithReuseIdentifier: ProfileEventCell.identifier)
        collectionView.register(ProfileHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: ProfileHeaderView.identifier)
    }
    
    private func setupNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: logOutButton)
    }
    
    // MARK: Actions
    @objc private func logOutBtn() {
        showConfirmationAlert(withTitle: "Log Out", message: "Are you sure you want to log out?", confirmationHandler: {
            AuthManager.shared.logOut(completion: { success in
                DispatchQueue.main.async {
                    if success {
                        // Present log in
                        let loginVC = LoginViewController()
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
}

// MARK: - UICollectionViewDataSource
extension ProfileViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.events.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileEventCell.identifier, for: indexPath) as! ProfileEventCell
        cell.event = viewModel.events[indexPath.row]
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension ProfileViewController {
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ProfileHeaderView.identifier, for: indexPath) as! ProfileHeaderView
        header.user = viewModel.user
        return header
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = DetailsEventViewController()
        controller.delegate = self
        controller.event = viewModel.events[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ProfileViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }
}

extension ProfileViewController: EventsVMDelegate {
    func didShowAlert() {
        showAlert(withTitle: "Let's go to sports!", message: "Please add new events")
    }
    
    func didUpdateEvents(_ events: [Event]) {
        collectionView.reloadData()
    }
}

extension ProfileViewController: ProfileViewControllerDelegate {
    func didDeleteEvent(withID eventID: String) {
        viewModel.deleteEvent(withID: eventID)
        collectionView.reloadData()
    }
}
