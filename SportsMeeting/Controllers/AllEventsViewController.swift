//
//  AllEventsViewController.swift
//  SportsMeeting
//
//  Created by  Sasha Khomenko on 27.02.2023.
//

import UIKit

class AllEventsViewController: UICollectionViewController {

    private var events = [Event]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "All Events"
        view.backgroundColor = .systemBackground
        configureUI()
        fetchTweets()
    }
    
    func fetchTweets() {
        DatabaseManager.shared.fetchEvents { events in
            self.events = events
        }
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: collectionView.bounds.width - 10, height: 200)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(EventCell.self, forCellWithReuseIdentifier: EventCell.identifier)
    }
}

// MARK: - UICollectionViewDelegate/DataSource

extension AllEventsViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return events.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventCell.identifier, for: indexPath) as! EventCell
        cell.event = events[indexPath.row]
        return cell
    }
}
