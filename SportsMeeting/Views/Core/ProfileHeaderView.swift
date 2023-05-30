//
//  ProfileView.swift
//  SportsMeeting
//
//  Created by  Sasha Khomenko on 03.04.2023.
//

import UIKit

class ProfileHeaderView: UICollectionReusableView {
    
    static let identifier = "ProfileHeaderView"
    
    // MARK: - Properties
    var user: User? {
        didSet { configure() }
    }
    
    private let profileImageView: UIImageView = {
        let iv = UIImageView ()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        iv.layer.borderColor = UIColor.white.cgColor
        iv.layer.borderWidth = 4
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let fullnameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(profileImageView)
        profileImageView.setDimensions(width: 80, height: 80)
        profileImageView.layer.cornerRadius = 80 / 2

        let userDetailsStack = UIStackView(arrangedSubviews: [fullnameLabel])
        userDetailsStack.axis = .vertical
        userDetailsStack.distribution = .fillProportionally
        userDetailsStack.spacing = 4
        userDetailsStack.translatesAutoresizingMaskIntoConstraints = false

        addSubview(userDetailsStack)
        NSLayoutConstraint.activate([
            
            profileImageView.safeAreaLayoutGuide.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            profileImageView.safeAreaLayoutGuide.leadingAnchor.constraint(equalTo: leadingAnchor),
            profileImageView.centerXAnchor.constraint(equalTo: centerXAnchor),

            userDetailsStack.topAnchor.constraint(equalTo: profileImageView.bottomAnchor),
            userDetailsStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            userDetailsStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            userDetailsStack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func configure() {
        guard let user = user else { return }
        profileImageView.sd_setImage(with: user.profileImageUrl)
        fullnameLabel.text = user.fullName
    }
}
