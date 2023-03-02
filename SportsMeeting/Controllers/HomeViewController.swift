//
//  HomeViewController.swift
//  SportsMeeting
//
//  Created by  Sasha Khomenko on 27.02.2023.
//

import UIKit
import MapKit

class HomeViewController: UIViewController {
    
    private let mapLabel: UILabel = {
        let label = UILabel()
        label.text = "Map Of Events"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Gill Sans", size: 20)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private let myEventsLabel: UILabel = {
        let label = UILabel()
        label.text = "My Events"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Gill Sans", size: 20)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private let mapView: MKMapView = {
        let map = MKMapView()
        map.overrideUserInterfaceStyle = .light
        map.translatesAutoresizingMaskIntoConstraints = false
        map.cornerRadius = 10
        map.layer.borderWidth = 0.5
        map.layer.borderColor = UIColor.black.cgColor
        return map
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Home"
        setupViews()
    }
    
    private func setupViews(){
        view.addSubview(mapLabel)
        view.addSubview(mapView)
        view.addSubview(myEventsLabel)
        
        NSLayoutConstraint.activate([
            
            mapLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            mapView.topAnchor.constraint(equalTo: mapLabel.bottomAnchor, constant: 10),
            mapView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            mapView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            mapView.heightAnchor.constraint(equalToConstant: 300),
            
            myEventsLabel.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 10),
            myEventsLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
        ])
    }
}
