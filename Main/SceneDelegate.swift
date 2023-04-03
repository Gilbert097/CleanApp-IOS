//
//  SceneDelegate.swift
//  Main
//
//  Created by Gilberto Silva on 14/03/23.
//

import UIKit
import UI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    private let signUpFactory: () -> SignUpViewController = {
        let httpClient = makeAlamofireAdapter()
        let addAccount = makeRemoteAddAccount(httpClient: httpClient)
        return makeSignUpController(addAccount: addAccount)
    }
    
    private let loginFactory: () -> LoginViewController = {
        let httpClient = makeAlamofireAdapter()
        let authentication = makeRemoteAuthentication(httpClient: httpClient)
        return makeLoginController(authentication: authentication)
    }
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let nav = NavigationController()
        let router = WelcomeRouter(nav: nav, loginFactory: loginFactory, signUpFactory: signUpFactory)
        let viewController = WelcomeViewController()
        viewController.login = router.goToLogin
        viewController.signUp = router.goToSignUp
        nav.setRootViewController(viewController)
        self.window?.makeKeyAndVisible()
        self.window?.windowScene = windowScene
        self.window?.rootViewController = nav
    }
}
