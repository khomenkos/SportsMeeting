//
//  HomeViewController.swift
//  SportsMeeting
//
//  Created by  Sasha Khomenko on 27.02.2023.
//

import UIKit

class HomeViewController: UICollectionViewController {
    
    // MARK: - Variables
    private var viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Home"
        viewModel.delegate = self
        
        viewModel.fetchEvents()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchEvents()
    }
    
    // MARK: - Helpers
    private func configureUI() {
        let locationButton = UIButton(type: .system)
           locationButton.setImage(UIImage(systemName: "location"), for: .normal)
           locationButton.addTarget(self, action: #selector(locationButtonTapped(_:)), for: .touchUpInside)
           let locationBarButtonItem = UIBarButtonItem(customView: locationButton)

           let filterButton = UIButton(type: .system)
           filterButton.setImage(UIImage(systemName: "line.horizontal.3.decrease.circle"), for: .normal)
           filterButton.addTarget(self, action: #selector(filterButtonTapped(_:)), for: .touchUpInside)
           let filterBarButtonItem = UIBarButtonItem(customView: filterButton)

           navigationItem.rightBarButtonItems = [filterBarButtonItem, locationBarButtonItem]
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.bounds.width - 10, height: 165)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(EventCell.self, forCellWithReuseIdentifier: EventCell.identifier)
    }
    
    @objc private func filterButtonTapped(_ sender: UIButton) {
        showSportTypeSelection()
    }
    
    @objc private func locationButtonTapped(_ sender: UIButton) {
        showLocationInputAlert()
    }
    
    private func showLocationInputAlert() {
        let alertController = UIAlertController(title: "Enter Your City", message: nil, preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "City"
        }

        let searchAction = UIAlertAction(title: "Search", style: .default) { [weak self] _ in
            if let city = alertController.textFields?.first?.text {
                self?.viewModel.filterEventsByLocation(city)
            }
        }
        alertController.addAction(searchAction)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)

        present(alertController, animated: true, completion: nil)
    }
    
    private func showSportTypeSelection() {
        let alertController = UIAlertController(title: "Select Sport Type", message: nil, preferredStyle: .actionSheet)
        alertController.popoverPresentationController?.sourceView = navigationItem.rightBarButtonItem?.customView
        
        let sportTypes = ["All", "Run", "Gym", "Football", "Basketball", "Tennis", "Volleyball", "Hockey"]
        for sportType in sportTypes {
            let action = UIAlertAction(title: sportType, style: .default) { [weak self] _ in
                self?.viewModel.filterEventsBySportType(sportType)
            }
            alertController.addAction(action)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
}

// MARK: - UICollectionViewDelegate/DataSource
extension HomeViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.events.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventCell.identifier, for: indexPath) as! EventCell
        cell.event = viewModel.events[indexPath.row]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = DetailsEventViewController()
        controller.event = viewModel.events[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension HomeViewController: EventsVMDelegate {
    func didShowAlert() {
        showAlert(withTitle: "Event not found", message: "Please try again")
    }
    
    func didUpdateEvents(_ events: [Event]) {
        collectionView.reloadData()
    }
}
