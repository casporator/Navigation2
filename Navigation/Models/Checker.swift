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
    
    private let login = "1"
    private let password = "1"
    
    func checkLogin(login: String, password: String) -> Bool {
        self.login == login && self.password == password ? true : false
    }
    
    private init(){
        
    }
}

struct LoginInspector: LoginViewControllerDelegate {
    func checkLogin(controller: LoginViewController,
                    login: String, password: String) -> Bool {
        return Checker.shared.checkLogin(login: login, password: password)
        
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
