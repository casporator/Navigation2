//
//  AppDelegate.swift
//  Navigation
//
//  Created by Oleg Popov on 15.08.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var appConfiguration: AppConfiguration?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        appConfiguration = AppConfiguration.allCases.randomElement()
        let urlString = String(appConfiguration?.rawValue ?? "")
        
        NetworkService.performRequest(with: urlString)
        print("Downloading data from: \(urlString)")
        
        InfoNetworkService.titleRequest()
        InfoNetworkService.orbitaRequest()
        return true
            
  
       
    }
        

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
       
    }


}

