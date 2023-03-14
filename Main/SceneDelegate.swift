//
//  SceneDelegate.swift
//  Main
//
//  Created by Gilberto Silva on 14/03/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        self.window?.rootViewController = SignUpFactory.makeController()
        self.window?.makeKeyAndVisible()
    }
}
