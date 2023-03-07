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
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        //stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.layer.cornerRadius = 10
        stackView.layer.borderWidth = 1
        stackView.layer.borderColor = UIColor.black.cgColor
        return stackView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Gill Sans SemiBold", size: 20)
        label.textAlignment = .center
        label.textColor = .darkGray
        return label
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Gill Sans Light", size: 17)
        label.textColor = .darkGray
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Gill Sans Light", size: 17)
        label.textColor = .darkGray
        return label
    }()
    
    private let sportTypeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Gill Sans Light", size: 17)
        label.textColor = .darkGray
        return label
    }()
    
    private let userPublishLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Gill Sans Light", size: 15)
        label.textColor = .lightGray
        label.textAlignment = .center
        return label
    }()
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        //addSubview(titleLabel)
        addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(locationLabel)
        stackView.addArrangedSubview(dateLabel)
        stackView.addArrangedSubview(sportTypeLabel)
        stackView.addArrangedSubview(userPublishLabel)
//
//        NSLayoutConstraint.activate([
//            titleLabel.heightAnchor.constraint(equalToConstant: 45),
//            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
//            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
//            
//            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
//            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
//            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
//            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 5)
//        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        stackView.frame = contentView.bounds
    }
    
    
    private func configure() {
        guard let event = event else { return }
        let viewModel = EventViewModel(event: event)
        
        titleLabel.text = event.nameEvent
        locationLabel.text = "Location: " + event.location
        dateLabel.text = "Data&Time: " + event.dateTime
        sportTypeLabel.text = "Sport Type: " + event.sportType
        userPublishLabel.attributedText = viewModel.userInfoText
    }
}
