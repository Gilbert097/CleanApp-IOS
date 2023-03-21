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
        let addAccount = UseCaseFactory.makeRemoteAddAccount()
        let viewController = SignUpComposer.composeViewControllerWith(addAccount: addAccount)
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.makeKeyAndVisible()
        self.window?.windowScene = windowScene
        self.window?.rootViewController = viewController
    }
}
