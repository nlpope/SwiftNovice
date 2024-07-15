//
//  AppDelegate.swift
//  SwiftNovice
//
//  Created by Noah Pope on 7/14/24.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "SwiftNovice")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}


//MARK: NOTES SECTION
/**
 swift @ version: 5.10.1
 xcode @ version: 15.4
 --------------------------
 SHORTCUTS (GENERAL):
 
 *  access quick actions (XCode 15) = cmd + shift + a
 > use to access 'minimap'
 > use to quick change 'theme' - current = midnight
 *  bookmark goals by right clicking a line
 > more preferably, type '#warning("message")' instead to have 'return to' items clear & present
 *  clean XCode build folder = cmd + shift + K
 *  create new code snippets: right click + "create code snippet"
 *  duplicate a line = cmd + D
 *  edit multiple lines at once: control + shift + click away then start typing
 > or opt + click & drag down
 *  edit this / saved code snippet: cmd + shift + L
 *  emoji keyboard: cmd + cntrl + spacebar 😎
 *  force quit on mac: cmd + opt + esc
 *  importing UIKit also imports Foundation (never import Foundation if UIkit is in play)
 *  new XCode internal tab = cmd + ctrl + T
 > hotkey for this = opt + click any file in your project folder
 *  storyboard object list: cmd + shift + L (double check?)
 
 SHORTCUTS (HIDE / REVEAL PANES):
 
 *  hide/reveal debug & console area = cmd + shift + Y
 > hide/reveal console = cmd + shift + c
 *  hide/reveal left pane = cmd + 0
 *  hide/reveal right pane = cmd + shift + 0
 *  hide/reveal preview window = cmd + shift + enter
 *  hide/reveal minimap = cntrl + shift + cmd + m || access quick actions > type 'minimap'
 
 *  source = see Stanford: https://www.youtube.com/watch?v=CRxHhx_pubY&list=PL3d_SFOiG7_8ofjyKzX6Nl1wZehbdiZC_&index=3&ab_channel=CS193P
 
 --------------------------
 XXXXXXXXXXXXXXXXXXXXXXXX
 XXXXXXXXXXXXXXXXXXXXXXXX
 --------------------------
 
 HELPFUL TIPS:
 
 *  App Icons & Image sets:
 >  https://www.appicon.co/#app-icon
 >  https://www.appicon.co/#image-sets
 
 *  Code formatting:
 > order = vars/lets, init methods, view lifecycle methods (VDL), funcs
 > 1 space after imports
 > 1 space BETWEEN class / struct / enum declarations
 > 1 space AFTER class / struct / enum declarations
 > 2 spaces after vars just before methods
 > 2 spaces between funcs
 >> no spaces on 1st line after func declaration
 
 *  Debugging
 > see Stanford: https://www.youtube.com/watch?v=CRxHhx_pubY&list=PL3d_SFOiG7_8ofjyKzX6Nl1wZehbdiZC_&index=3&ab_channel=CS193P
 
 *  DispatchQueue-ing to main thread:
 > updating UI? - switch to main thread
 >> ex: DispatchQueue.main.async { self.image = image }
 
 *  Folders = instead of MVC, MVVM, etc. start with:
 > Extensions - "...+Ext"
 > Utilities (error msgs, constant enums, UIHelpers) - "...+Utils"
 > Managers
 > Models
 > CustomViews
 > Screens (VCs)
 > Support (App/Scene Delegate, Assets, the rest)
 >> except info.plist, leave this outside/alone
 
 *  Human interface guidelines: https://developer.apple.com/design/human-interface-guidelines
 
 *  MVC = "Does my View Controller need to know about this?":
 >  basically if you see NO GREEN TEXT (ref's to props created in the VC) in the func, it can be refactored to another file.
 >> the background color, border width, & corner radius of a container for an alert? No; Include in separate UIView
 >> NSLayoutContstraints for the container? Yes.
 >> if a refactored view was referenced in the OG func and is throwing an error once you move it, pass in the view using: func functionName(in view: UIView) { }
 
 *  Network calls:
 > best to keep your .success, .failure & switch statement cases contained to 1-2 readable lines of code - factor out if need be. for example:
 >>    case .success(let followers):
 updateUI(with: followers)
 >> NOTE: not always possible, if it's 4 lines & depends on a complex completion handler, so be it
 
 *  Padding & constraints:
 >  whatever your fontSize is set to, give your label 4 extra points of padding in the NSLayoutConstraints below it  to account for letters that dip below baseline (y, j, g, etc)
 
 --------------------------
 XXXXXXXXXXXXXXXXXXXXXXXX
 XXXXXXXXXXXXXXXXXXXXXXXX
 --------------------------
 
 PROJECT NOTES:
 *  Biggest Struggles:
 >
 
 --------------------------
 * FileName
 1.
 
 --------------------------
 
 */


