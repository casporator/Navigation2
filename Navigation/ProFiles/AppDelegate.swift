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
    


}




