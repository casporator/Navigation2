//
//  Checker.swift
//  Navigation
//
//  Created by Oleg Popov on 18.10.2022.
//

import Foundation

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
    
    func checkLogin(login: String, password: String) -> Result<Bool, loginError>  {
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
        case .failure(loginError.loginEmpty):
            print("Error: Поле логина не заполненно")
            return false
        case .failure(loginError.passwordEmpty):
            print("Error: Поле пароля не заполнеено")
            return false
        case .failure(loginError.empty):
            print("Error: Оба заполняемых поля пустые")
            return false
        case .failure(loginError.incorrect):
            print("Error: Не правильный логин или пароль")
            return false
        case .success(false):
            print("Error: Не известная ошибка")
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
