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
        print("didFinishLaunchingWithOptions")
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
 XXXXXXXXXXXXXXXXXXXXXXXX
 XXXXXXXXXXXXXXXXXXXXXXXX
 --------------------------
 WHAT I LEARNED
 * How to create my own 'GET' API through server side Swift using Vapor
 >  deeper understanding of generics and variadic parameters in action
 >  deeper understanding of inout (&) parameters in action - allows mutation of a let const. via a pointer
 
 * Unit testing
 
 --------------------------
 XXXXXXXXXXXXXXXXXXXXXXXX
 XXXXXXXXXXXXXXXXXXXXXXXX
 --------------------------
 WHAT I STRUGGLED WITH
 * in the Vapor server I was having issues using my 'multiAppend' extension for the Array type
 >  it kept returning an empty array
 >  turns out I wrote the extension's for loop wrong, it read 'for item in array { array.append(item)}' when the array was empty to begin with
 >  twas fixed when I said 'for course in courses...' - I was referencing the wrong parameter in the for loop. worked fine after that
 >  Here i was thinking it was a concurrency issue
 
 * Unit testing
 > The network manager's fetch operation kept failing when I XCAsserted true for !self.prerequisites.isempty.
 > But I originally had that asssertion outside of the network call which was asynchronous so of course the empty array would remain empty after the network call func was fired
 > it wasn't until I put the XCAssertion inside the completion handler's braces that I could assert the value just after the returned array was appended to the emty top level array.
 
 --------------------------
 XXXXXXXXXXXXXXXXXXXXXXXX
 XXXXXXXXXXXXXXXXXXXXXXXX
 --------------------------
 SHORTCUTS & HELPFUL TIPS (XCODE & SWIFT):
 * Link:
 https://docs.google.com/document/d/1yunA83JZ4FxS_WuIQMRwm6gkUDJC1jnkJ2Vtll8kid8/edit?usp=sharing
 
 --------------------------
 XXXXXXXXXXXXXXXXXXXXXXXX
 XXXXXXXXXXXXXXXXXXXXXXXX
 --------------------------
 PROJECT NOTES:
 * Link:
 https://docs.google.com/document/d/1H16oibuQ_CakODNKcfurkgoYvvhRmKKfeDc8gDRJmdY/edit?usp=sharing
 
 */


