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
//        if login == "" && password != "" {
//            return .failure(.loginEmpty)
//        }
//        if password == "" && login != "" {
//            return.failure(.passwordEmpty)
//        }
//        if login == "" && password == "" {
//            return .failure(.empty)
//        }
//        else {
            return .failure(.incorrect)
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
    let alert = UIAlertController(title: "ERROR", message: message, preferredStyle: .actionSheet)
    let actionOne = UIAlertAction(title: "OK", style: .default)
    alert.addAction(actionOne)
    UIApplication.topViewController()!.present(alert, animated: true, completion: nil)
}





