//
//  CheckerService.swift
//  Navigation
//
//  Created by Oleg Popov on 03.12.2022.
//

import Foundation
import FirebaseAuth
import UIKit

protocol CheckerServiceProtocol {
    func checkCredentials(login: String, password: String)
    func signUp(login: String, password: String)
}

class CheckerService: CheckerServiceProtocol {
   
    static let shared = CheckerService()
    
   
    var isSingIn: Bool = false
    
    func checkCredentials(login: String, password: String) {
        Auth.auth().signIn(withEmail: login, password: password) { [self] result, error in
            if let error = error {
                print("error: \(error)")
                let err = error as NSError
                switch err.code {
                //Если пользователь не найден - предлагаем создать:
                case AuthErrorCode.userNotFound.rawValue:
                    let alert = UIAlertController(title: "User not found", message: "Do you want to create this account as new?", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "No", style: .cancel ))
                    alert.addAction(UIAlertAction(title: "Register", style: .default, handler: {_ in self.signUp(login: login, password: password)}))
                    UIApplication.topViewController()!.present(alert, animated: true, completion: nil)
               
                default:
                    AlertErrors.shared.alert(alertTitle: "Login error", alertMessage: error.localizedDescription)
                }
            } else {
                isSingIn = true
            }
        }
    }
    
    func signUp(login: String, password: String) {
            Auth.auth().createUser(withEmail: login, password: password) { result, error in
                if let error = error {
                    //Любые ошибки (например длина пароля)
                    AlertErrors.shared.alert(alertTitle: "Registration error", alertMessage: error.localizedDescription)
                } else {
                    AlertErrors.shared.alert(alertTitle: "Congratulations!", alertMessage: "Your account has been successfully created")
                }
            }
    }
}


