//
//  SceneDelegate.swift
//  SportsMeeting
//
//  Created by  Sasha Khomenko on 27.02.2023.
//

import UIKit
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
    
        // Check if the user has been saved to Firebase
        if Auth.auth().currentUser != nil {
            // If yes, then open tabBarViewController
            let vc = TabBarViewController()
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = vc
            window.makeKeyAndVisible()
            self.window = window
        } else {
            // If not, then open the login screen
            let vc = LoginViewController()
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = vc
            window.makeKeyAndVisible()
            self.window = window
        }
    }
}

