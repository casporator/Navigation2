//
//  CurrentUserService.swift
//  Navigation
//
//  Created by Oleg Popov on 06.11.2022.
//

import Foundation
import UIKit


class CurrentUserService: UserService {
    
    let user: User = .init(userName: "Mr.Pipin", userAvatar: UIImage(named: "pipin") ?? UIImage(), userStatus: "Мои шесть кубиков защищены слоем жира")
    
    func returnUser(userName: String) -> User? {
        
       if userName == user.userName {
            return user
        }
            return nil
    }
    
}
   
