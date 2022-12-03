//
//  LoginInspector.swift
//  Navigation
//
//  Created by Oleg Popov on 03.12.2022.
//

import Foundation
struct LoginInspector: LoginViewControllerDelegate {
    func checkLogin(controller: LoginViewController,
                    login: String, password: String) -> Bool {
       CheckerService.shared.checkCredentials(login: login, password: password)
        if CheckerService.shared.isSingIn == true {
            return true
        } else {
            return false
        }
    }
}
        
//        switch Checker.shared.checkLogin(login: login, password: password) {
//        case .success(true):
//            print("Логин и пароль - верны")
//            return true
//        case .failure(LoginError.loginEmpty):
//            loginAlert(message: "THE EMAIL FIELD IS NOT WRITEN:\nPlease enter your email")
//            return false
//        case .failure(LoginError.passwordEmpty):
//            loginAlert(message: "THE PASSWORD FIELD IS NOT WRITEN:\nPlease enter your password")
//            return false
//        case .failure(LoginError.empty):
//            loginAlert(message: "THE EMAIL & PASSWORD FIELD IS NOT WRITEN:\nPlease enter your email & password")
//            return false
//        case .failure(LoginError.incorrect):
//            loginAlert(message: "INCORRECT EMAIL or PASSWORD:\nCheck the correctness of the input email or password ")
//            return false
//        case .success(false):
//            loginAlert(message: "UNKNOWN ERROE")
//            return false
//        }
//
//    }
//}
        
