//
//  SceneDelegate.swift
//  Main
//
//  Created by Gilberto Silva on 14/03/23.
//

import UIKit
import UI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let nav = NavigationController()
        let welcomeViewController = makeWelcomeController(nav: nav)
        nav.setRootViewController(welcomeViewController)
        self.window?.makeKeyAndVisible()
        self.window?.windowScene = windowScene
        self.window?.rootViewController = nav
    }
}
