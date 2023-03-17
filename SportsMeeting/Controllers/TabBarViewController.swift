//
//  TabBarViewController.swift
//  SportsMeeting
//
//  Created by  Sasha Khomenko on 27.02.2023.
//

import UIKit

final class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabs()
    }

    private func setUpTabs() {
        let homeVC = HomeViewController()
        let chatVC = ChatViewController()
        let addEventsVC = AddEventViewController()
        let allEventsVC = AllEventsViewController(collectionViewLayout: UICollectionViewFlowLayout())
        let accountVC = AccountViewController()

        homeVC.navigationItem.largeTitleDisplayMode = .automatic
        chatVC.navigationItem.largeTitleDisplayMode = .automatic
        addEventsVC.navigationItem.largeTitleDisplayMode = .never
        allEventsVC.navigationItem.largeTitleDisplayMode = .automatic
        accountVC.navigationItem.largeTitleDisplayMode = .never

        let nav1 = UINavigationController(rootViewController: homeVC)
        let nav2 = UINavigationController(rootViewController: chatVC)
        let nav3 = UINavigationController(rootViewController: addEventsVC)
        let nav4 = UINavigationController(rootViewController: allEventsVC)
        let nav5 = UINavigationController(rootViewController: accountVC)

        nav1.tabBarItem = UITabBarItem(title: "Home",
                                       image: UIImage(systemName: "house"),
                                       tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Chat",
                                       image: UIImage(systemName: "captions.bubble"),
                                       tag: 2)
        nav3.tabBarItem = UITabBarItem(title: "Add Event",
                                       image: UIImage(systemName: "plus"),
                                       tag: 3)
        nav4.tabBarItem = UITabBarItem(title: "All Events",
                                       image: UIImage(systemName: "figure.run"),
                                       tag: 4)
        nav5.tabBarItem = UITabBarItem(title: "Account",
                                       image: UIImage(systemName: "person.circle"),
                                       tag: 4)

        for nav in [nav1, nav2, nav3, nav4, nav5] {
            nav.navigationBar.prefersLargeTitles = true
        }

        setViewControllers(
            [nav1, nav2, nav3, nav4, nav5],
            animated: true
        )
    }
}
