//
//  ProfileEventCell.swift
//  SportsMeeting
//
//  Created by  Sasha Khomenko on 03.04.2023.
//

import UIKit

class ProfileEventCell: UICollectionViewCell {
    
    static let identifier = "ProfileEventCell"
    
    // MARK: - Properties
    var event: Event? {
        didSet { configure() }
    }
    
    // MARK: Outlets
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Galvji Bold", size: 18)
        label.textAlignment = .center
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
        label.layer.cornerRadius = 15
        label.backgroundColor = .white
        label.clipsToBounds = true
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
        label.layer.cornerRadius = 15
        label.backgroundColor = .white
        label.clipsToBounds = true
        label.layer.borderWidth = 2
        label.layer.borderColor = UIColor.lightGray.cgColor
        return label
    }()
    
    private lazy var locationButton: UIButton = {
        let button = UIButton()
        button.tintColor = UIColor.customDarkBlue
        button.setDimensions(width: 48, height: 48)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.sizeSymbol(name: "location.fill.viewfinder", size: 48, weight: .light, scale: .medium)
        button.addTarget(self, action: #selector(locationBtn), for: .touchUpInside)
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
    
    // MARK: Actions
    @objc func locationBtn() {
    }
    
    // MARK: Setup UI
    private func configure() {
        guard let event = event else { return }
        titleLabel.text = event.nameEvent
        dateLabel.text = event.dateTime
        sportTypeLabel.text = event.sportType
    }
    
    private func setupUI() {
        shadowSetup(color: UIColor.gray.cgColor, opacity: 1, radius: 3)
        backgroundColor = UIColor(named: "lightGray")
        addSubview(locationButton)
        addSubview(titleLabel)
        addSubview(descriptionContainer)
        descriptionContainer.addArrangedSubview(sportTypeLabel)
        descriptionContainer.addArrangedSubview(dateLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 12),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
        ])
        
        NSLayoutConstraint.activate([
            locationButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 7),
            locationButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 12),
        ])
        
        NSLayoutConstraint.activate([
            descriptionContainer.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 7),
            descriptionContainer.leadingAnchor.constraint(equalTo: locationButton.trailingAnchor, constant: 12),
            descriptionContainer.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -12),
            descriptionContainer.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
}
