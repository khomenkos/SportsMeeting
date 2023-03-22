//
//  AllEventsViewController.swift
//  SportsMeeting
//
//  Created by  Sasha Khomenko on 27.02.2023.
//

import UIKit
import FirebaseAuth

class MyEventsViewController: UICollectionViewController {

    private var events = [Event]() {
        didSet {
            collectionView.reloadData()
        }
    }

    var user: User? {
        didSet {
            fetchEvents()
        }
    }

    func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        DatabaseManager.shared.fetchUser(uid: uid) { user in
            self.user = user
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My Events"
        configureUI()
        fetchUser()
    }

    func fetchEvents() {
        guard let user = user else { return }
        DatabaseManager.shared.fetchEvents(forUser: user) { events in
            self.events = events
        }
    }


    // MARK: - Helpers

    func configureUI() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: collectionView.bounds.width - 10, height: 165)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(EventCell.self, forCellWithReuseIdentifier: EventCell.identifier)
    }
}

// MARK: - UICollectionViewDelegate/DataSource

extension MyEventsViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return events.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventCell.identifier, for: indexPath) as! EventCell
        cell.event = events[indexPath.row]
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = DetailsEventViewController()
        controller.event = events[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
    }
}
