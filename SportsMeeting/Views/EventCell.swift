//
//  EventCell.swift
//  SportsMeeting
//
//  Created by  Sasha Khomenko on 04.03.2023.
//

import UIKit

class EventCell: UICollectionViewCell {

    static let identifier = "EventCell"

    // MARK: - Properties
    
    var event: Event? {
        didSet { configure() }
    }
    
    private lazy var container: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "lightGray")
        view.cornerRadius = 15
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()
    
    private lazy var profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .black
        iv.clipsToBounds = true
        iv.setDimensions(width: 48, height: 48)
        iv.layer.cornerRadius = 48 / 2
        //let tap = UITapGestureRecognizer(target: self, action: #selector(handleProfileImageTapped))
        //iv.addGestureRecognizer(tap)
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.borderWidth = 2
        iv.layer.borderColor = UIColor.white.cgColor
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Galvji Bold", size: 18)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var descriptionContainer: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .center
        stack.spacing = 20
        stack.alignment = .fill
        stack.distribution = .fillEqually
        return stack
    }()
    
    private let sportTypeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Galvji Bold", size: 15)
        label.textColor = .darkGray
        label.textAlignment = .center
        label.cornerRadius = 15
        label.backgroundColor = .white
        label.layer.borderWidth = 2
        label.layer.borderColor = UIColor.lightGray.cgColor
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Galvji Bold", size: 15)
        label.textAlignment = .center
        label.textColor = .darkGray
        label.numberOfLines = 3
        label.cornerRadius = 15
        label.backgroundColor = .white
        label.layer.borderWidth = 2
        label.layer.borderColor = UIColor.lightGray.cgColor
        return label
    }()
    
    private let userPublishLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Gill Sans Light", size: 15)
        label.textColor = .lightGray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var locationButton: UIButton = {
        let button = UIButton()
        button.tintColor = UIColor(named: "darkBlue")
        button.setDimensions(width: 48, height: 48)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.sizeSymbol(name: "location.fill.viewfinder", size: 48, weight: .light, scale: .medium)

        button.addTarget(self, action: #selector(locationBtn), for: .touchUpInside)
        return button
    }()
    
    @objc func locationBtn() {
        
    }
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 3
        
        backgroundColor = .clear
        addSubview(container)
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            container.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            container.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            container.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
        ])
        
        container.addSubview(profileImageView)
        container.addSubview(locationButton)
        container.addSubview(titleLabel)
        container.addSubview(descriptionContainer)
        descriptionContainer.addArrangedSubview(sportTypeLabel)
        descriptionContainer.addArrangedSubview(dateLabel)
        container.addSubview(userPublishLabel)
                
        NSLayoutConstraint.activate([
            profileImageView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 12),
            profileImageView.topAnchor.constraint(equalTo: container.topAnchor, constant: 12),

            titleLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 12),
            titleLabel.heightAnchor.constraint(equalToConstant: 48),
            
            locationButton.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 7),
            locationButton.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 12),
            
            descriptionContainer.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 7),
            descriptionContainer.leadingAnchor.constraint(equalTo: locationButton.trailingAnchor, constant: 12),
            descriptionContainer.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -12),

            descriptionContainer.heightAnchor.constraint(equalToConstant: 48),

            userPublishLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 12),
            userPublishLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -5),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        guard let event = event else { return }
        let viewModel = EventViewModel(event: event)
        
        profileImageView.sd_setImage(with: viewModel.profileImageUrl)
        titleLabel.text = event.nameEvent
        dateLabel.text = event.dateTime
        sportTypeLabel.text = event.sportType
        userPublishLabel.attributedText = viewModel.userInfoText
    }
}
