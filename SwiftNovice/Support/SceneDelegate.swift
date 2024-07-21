//
//  SceneDelegate.swift
//  SwiftNovice
//
//  Created by Noah Pope on 7/14/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        // replace below w 'didSet' prop observer so else block can fire
        #warning("don't forget to DISMISS the signInVC or memory will leak")
//        var userLoggedIn: Bool      = PersistenceManager.retrieveLoggedInStatus() {
//            didSet {
//                determineRootVC()
//            }
//        }
        guard let windowScene       = (scene as? UIWindowScene) else { return }
            
        window                      = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene         = windowScene
        window?.rootViewController  = determineRootVC()
        window?.makeKeyAndVisible()
        
        configureNavigationBar()
    }
    
    
    func determineRootVC() -> UIViewController {
        let userIsLoggedIn = PersistenceManager.retrieveLoggedInStatus()
        guard userIsLoggedIn else { return SignInVC() }
        return SNTabBarController()
    }
    
    
    func changeRootVC(_ vc: UIViewController, animated: Bool = true) {
        guard let window = self.window else { return }
        
        window.rootViewController = vc
        // add logic for sign out button later
    }
    
    
    func configureNavigationBar() {
        UINavigationBar.appearance().tintColor = .systemBlue
    }
    

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
        print("sceneDidDisconnect")
        PersistenceManager.updateLoggedInStatus(loggedIn: false)

    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

