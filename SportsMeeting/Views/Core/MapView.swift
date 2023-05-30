//
//  MapView.swift
//  SportsMeeting
//
//  Created by  Sasha Khomenko on 03.04.2023.
//

import UIKit
import MapKit

class MapView: UIView {

    // Images
    private(set) var mapPinImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "pin.fill")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.setDimensions(width: 40, height: 40)
        return imageView
    }()

    // Labels
    private(set) var addressLabel: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 15
        label.clipsToBounds = true
        label.backgroundColor = UIColor.customDarkBlue
        label.font = UIFont(name: "Gill Sans Light", size: 18)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        label.setDimensions(width: 300, height: 50)
        return label
    }()

    // Map
    private(set) var mapView: MKMapView = {
        let map = MKMapView()
        map.overrideUserInterfaceStyle = .light
        map.translatesAutoresizingMaskIntoConstraints = false
        map.layer.cornerRadius = 10
        map.layer.borderWidth = 2
        map.layer.borderColor = UIColor.lightGray.cgColor
        return map
    }()

    // Buttons
    private(set) var doneButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Gill Sans SemiBold", size: 16)
        button.layer.cornerRadius = 20
        button.backgroundColor = UIColor.customDarkBlue
        button.setDimensions(width: 200, height: 50)
        return button
    }()

    private(set) var userLocationButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 50 / 2
        button.backgroundColor = UIColor.customDarkBlue
        button.setImage(UIImage(systemName: "location"), for: .normal)
        button.setDimensions(width: 50, height: 50)
        return button
    }()

    private(set) var closeButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 50 / 2
        button.backgroundColor = UIColor.customDarkBlue
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.setDimensions(width: 50, height: 50)
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
    
    // MARK: Setup UI
    private func setupUI(){
        addSubview(mapView)
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: topAnchor),
            mapView.bottomAnchor.constraint(equalTo: bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])

        mapView.addSubview(mapPinImage)
        NSLayoutConstraint.activate([
            mapPinImage.centerXAnchor.constraint(equalTo: mapView.centerXAnchor),
            mapPinImage.centerYAnchor.constraint(equalTo: mapView.centerYAnchor, constant: -20)
        ])

        mapView.addSubview(closeButton)
        NSLayoutConstraint.activate([
            closeButton.leadingAnchor.constraint(equalTo: mapView.leadingAnchor, constant: 20),
            closeButton.topAnchor.constraint(equalTo: mapView.safeAreaLayoutGuide.topAnchor, constant: 20),
        ])

        mapView.addSubview(addressLabel)
        NSLayoutConstraint.activate([
            addressLabel.topAnchor.constraint(equalTo: mapView.safeAreaLayoutGuide.topAnchor, constant: 80),
            addressLabel.centerXAnchor.constraint(equalTo: mapView.centerXAnchor)
        ])

        mapView.addSubview(userLocationButton)
        NSLayoutConstraint.activate([
            userLocationButton.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -20),
            userLocationButton.bottomAnchor.constraint(equalTo: mapView.safeAreaLayoutGuide.bottomAnchor, constant: -40),
        ])

        mapView.addSubview(doneButton)
        NSLayoutConstraint.activate([
            doneButton.centerXAnchor.constraint(equalTo: mapView.centerXAnchor),
            doneButton.bottomAnchor.constraint(equalTo: mapView.safeAreaLayoutGuide.bottomAnchor, constant: -5),
        ])
    }
}
