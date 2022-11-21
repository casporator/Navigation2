//
//  SceneDelegate.swift
//  Navigation
//
//  Created by Oleg Popov on 15.08.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var feedTabNavigationController : UINavigationController!
    var profileTabNavigationController : UINavigationController!
    var loginTabNavigationController : UINavigationController!
    var playerTabNavigationController : UINavigationController!

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
            
       
        
       
        let tabBarController = UITabBarController()
        
        feedTabNavigationController = UINavigationController.init(rootViewController: FeedViewController())
        playerTabNavigationController = UINavigationController.init(rootViewController: TrackListController())
        profileTabNavigationController = UINavigationController.init(rootViewController: ProfileViewController())
        
        //MARK: Внедрите зависимость контроллера LoginViewController от LoginInspector:
        let loginController = LoginViewController()
        loginController.loginDelegate = MyLoginFactory().makeLoginInspector()
        
        loginTabNavigationController = UINavigationController.init(rootViewController: loginController)
        
        tabBarController.viewControllers = [loginTabNavigationController, playerTabNavigationController, feedTabNavigationController]
        
        let item2 = UITabBarItem(title: "Feed", image: UIImage(systemName: "rectangle.3.group.bubble.left"), tag: 0)
        let item1 = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.crop.circle"), tag: 2)
        let item3 = UITabBarItem(title: "Player", image: UIImage(systemName: "play.rectangle"), tag: 1)
        
        profileTabNavigationController.tabBarItem = item1
        feedTabNavigationController.tabBarItem = item2
        loginTabNavigationController.tabBarItem = item1
        playerTabNavigationController.tabBarItem = item3
        
        
        UITabBar.appearance().tintColor = .systemBlue
        UITabBar.appearance().backgroundColor = .white
        UITabBar.appearance().layer.borderColor = UIColor.darkGray.cgColor
        UITabBar.appearance().layer.borderWidth = 1
        UITabBar.appearance().layer.masksToBounds = true
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        self.window = window
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
       
    }

    func sceneWillResignActive(_ scene: UIScene) {
       
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        
    }


}

