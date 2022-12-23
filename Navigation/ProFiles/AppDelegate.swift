//
//  AppDelegate.swift
//  Navigation
//
//  Created by Oleg Popov on 15.08.2022.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var appConfiguration: AppConfiguration?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
//        appConfiguration = AppConfiguration.allCases.randomElement()
//        let urlString = String(appConfiguration?.rawValue ?? "")
        
//        NetworkService.performRequest(with: urlString)
//        print("Downloading data from: \(urlString)")
        
       
        appConfiguration = AppConfiguration.titleData
            if let urlString = appConfiguration {
        InfoNetworkService.titleRequest(for: urlString)
            } else {
                print("Bad url to request")
            }

            
        appConfiguration = AppConfiguration.planetData
            if let urlString = appConfiguration {
        InfoNetworkService.orbitaRequest(for: urlString)
            } else {
                print("Bad url to request")
            }

    
        FirebaseApp.configure()
        return true
            
  
       
    }
        
    func applicationWillTerminate(_ application: UIApplication) {
        do {
            // если закрываем приложение, то делаем логаут
            try Auth.auth().signOut()
        } catch {
            print("error")
        }
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
       
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "coreData")
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




