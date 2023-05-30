//
//  TabBarViewController.swift
//  SportsMeeting
//
//  Created by  Sasha Khomenko on 27.02.2023.
//

import UIKit
import FirebaseAuth

final class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabs()
    }
        
    private func setUpTabs() {
        let homeVC = HomeViewController(collectionViewLayout: UICollectionViewFlowLayout())
        let addEventsVC = AddEventViewController()
        let mapVC = MapViewController(mapType: .AllEvenstMap)
        let profileVC = ProfileViewController(collectionViewLayout: UICollectionViewFlowLayout())

        homeVC.navigationItem.largeTitleDisplayMode = .automatic
        addEventsVC.navigationItem.largeTitleDisplayMode = .never
        mapVC.navigationItem.largeTitleDisplayMode = .automatic
        profileVC.navigationItem.largeTitleDisplayMode = .never

        let nav1 = UINavigationController(rootViewController: homeVC)
        let nav3 = UINavigationController(rootViewController: addEventsVC)
        let nav4 = UINavigationController(rootViewController: mapVC)
        let nav5 = UINavigationController(rootViewController: profileVC)

        nav1.tabBarItem = UITabBarItem(title: "Home",
                                       image: UIImage(systemName: "house"),
                                       tag: 1)
        nav3.tabBarItem = UITabBarItem(title: "Add Event",
                                       image: UIImage(systemName: "plus"),
                                       tag: 3)
        nav4.tabBarItem = UITabBarItem(title: "Map",
                                       image: UIImage(systemName: "map"),
                                       tag: 4)
        nav5.tabBarItem = UITabBarItem(title: "Profile",
                                       image: UIImage(systemName: "person.circle"),
                                       tag: 5)

        for nav in [nav1, nav3, nav4, nav5] {
            nav.navigationBar.prefersLargeTitles = true
        }

        setViewControllers(
            [nav1, nav3, nav4, nav5],
            animated: true
        )
        tabBar.backgroundColor = .systemBackground
    }
}
