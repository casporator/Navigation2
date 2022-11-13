//
//  Checker.swift
//  Navigation
//
//  Created by Oleg Popov on 18.10.2022.
//

import Foundation
import UIKit

protocol LoginViewControllerDelegate{
    func checkLogin(controller: LoginViewController,
                    login: String, password: String) -> Bool
}

class Checker {
    static let shared = Checker()
    
    private var EnterLogin: String
    private var EnterPassword: String
    
    private init(){
        
        self.EnterLogin = "1"
        self.EnterPassword = "1"
        
  }
    
    func checkLogin(login: String, password: String) -> Result<Bool, LoginError>  {
        if login == EnterLogin && password == EnterPassword {
            return .success(true)
        }
        if login == "" && password != "" {
            return .failure(.loginEmpty)
        }
        if password == "" && login != "" {
            return.failure(.passwordEmpty)
        }
        if login == "" && password == "" {
            return .failure(.empty)
        }
        else {
            return .failure(.incorrect)
        }
    }
    
  
}

struct LoginInspector: LoginViewControllerDelegate {
    func checkLogin(controller: LoginViewController,
                    login: String, password: String) -> Bool {
        switch Checker.shared.checkLogin(login: login, password: password) {
        case .success(true):
            print("Логин и пароль - верны")
            return true
        case .failure(LoginError.loginEmpty):
            loginAlert(message: "The Email field is not written:\nPlease enter your email")
            return false
        case .failure(LoginError.passwordEmpty):
            loginAlert(message: "The password field is not written:\nPlease enter your password")
            return false
        case .failure(LoginError.empty):
            loginAlert(message: "The email and password fields is not writen:\nPlease enter your email & password")
            return false
        case .failure(LoginError.incorrect):
            loginAlert(message: "Incorrect email or password:\nCheck the correctness of the input email or password ")
            return false
        case .success(false):
            loginAlert(message: "Unknown error")
            return false
        }
        
    }
}
        

protocol LoginFactory {
    func makeLoginInspector() -> LoginInspector
}

struct MyLoginFactory : LoginFactory {
    func makeLoginInspector() -> LoginInspector {
        return LoginInspector()
    }
}

func loginAlert(message: String) {
    let alert = UIAlertController(title: "Error", message: message, preferredStyle: .actionSheet)
    let actionOne = UIAlertAction(title: "OK", style: .default)
    alert.addAction(actionOne)
    UIApplication.LoginViewController()!.present(alert, animated: true, completion: nil)
}

extension UIApplication {
    class func LoginViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return LoginViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return LoginViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return LoginViewController(controller: presented)
        }
        return controller
    }
}
