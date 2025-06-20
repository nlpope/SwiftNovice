//  File: AppDelegate.swift
//  Project: SwiftNovice
//  Created by: Noah Pope on 7/14/24.

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate
{
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    { print("didFinishLaunchingWithOptions"); return true }

    //-------------------------------------//
    // MARK: - UISCENESESSION LIFECYCLE

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration
    {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {}

    //-------------------------------------//
    // MARK: - CORE DATA STACK

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "SwiftNovice")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? { fatalError("Unresolved error \(error), \(error.userInfo)") }
        })
        return container
    }()

    //-------------------------------------//
    // MARK: - CORE DATA SAVING SUPPORT

    func saveContext()
    {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

//-------------------------------------//
// MARK: - NOTES SECTION

/**
 swift @ version: 6 (released 09.17.2024)
 iOS @ version: 18.5 (released 05.14.2025)
 xcode @ version: 16.3 (released 03.31.2025)
 --------------------------
 XXXXXXXXXXXXXXXXXXXXXXXX
 --------------------------
 PROBLEM TRACKING:
 * = problem
 >  = solution
 --------------------------
 * in the Vapor server I was having issues using my 'multiAppend' extension for the Array type
 >  it kept returning an empty array
 >  turns out I wrote the extension's for loop wrong, it read 'for item in array { array.append(item)}' when the array was empty to begin with
 >  twas fixed when I said 'for course in courses...' - I was referencing the wrong parameter in the for loop. worked fine after that
 >  Here i was thinking it was a concurrency issue
 --------------------------
 * Unit testing
 > The network manager's fetch operation kept failing when I XCAsserted true for !self.prerequisites.isempty.
 > But I originally had that asssertion outside of the network call which was asynchronous so of course the empty array would remain empty after the network call func was fired
 > it wasn't until I put the XCAssertion inside the completion handler's braces that I could assert the value just after the returned array was appended to the emty top level array.
 --------------------------
 XXXXXXXXXXXXXXXXXXXXXXXX
 --------------------------
 TECHNOLOGIES USED / LEARNED:
 * Swift
 * MIT's Swift Keychain Wrapper
 * Bakery (App Icon)
 --------------------------
 XXXXXXXXXXXXXXXXXXXXXXXX
 --------------------------
 HORNS-TO-TOOT::
 🎺 Learned how to create my own 'GET' API through server side Swift using Vapor
 >  deeper understanding of generics and variadic parameters in action
 >  deeper understanding of inout (&) parameters in action - allows mutation of a let const. via a pointer
 
 🎺 Implemented presentation controller's [.medium()] detents
 
 🎺 Implemented unit testing
 
 🎺 Gained deeper understanding of parent to child view controller relationships
 
 --------------------------
 XXXXXXXXXXXXXXXXXXXXXXXX
 --------------------------
 REFERENCES & CREDITS:
 * KeychainOptions.swift & SwiftKeychainWrapper by MIT's James Blair on 4/24/16.
 * Bakery was developed by Jordi Bruin: https://x.com/jordibruin
 --------------------------
 XXXXXXXXXXXXXXXXXXXXXXXX
 --------------------------
 */
