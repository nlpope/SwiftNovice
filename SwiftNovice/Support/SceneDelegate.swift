//  File: SceneDelegate.swift
//  Project: SwiftNovice
//  Created by: Noah Pope on 7/14/24.

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate
{
    var window: UIWindow?

    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions)
    {
        
        #warning("dismiss the signInVC then use instruments to avoid memory leak")
        guard let windowScene       = (scene as? UIWindowScene) else { return }
            
        window                      = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene         = windowScene
        window?.rootViewController  = determineRootVC()
        window?.makeKeyAndVisible()
        
        configureNavigationBar()
    }
    
    
    func determineRootVC() -> UIViewController
    {
        let userIsLoggedIn = PersistenceManager.retrieveLoggedInStatus()
        guard userIsLoggedIn else { return SignInVC() }
        return SNTabBarController()
    }
    
    
    func changeRootVC(_ vc: UIViewController, animated: Bool = true)
    {
        guard let window = self.window else { return }
        window.rootViewController = vc
        #warning("add logic for sign out button")
    }
    
    
    func configureNavigationBar() {
        UINavigationBar.appearance().tintColor = .systemBlue
    }
    

    func sceneDidDisconnect(_ scene: UIScene)
    {
        print("sceneDidDisconnect")
        PersistenceManager.updateLoggedInStatus(loggedIn: false)
    }

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) { PersistenceManager.isFirstVisitAfterDismissal = true }

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene)
    { (UIApplication.shared.delegate as? AppDelegate)?.saveContext() }
}
