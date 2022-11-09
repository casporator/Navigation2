//
//  TestUserService.swift
//  Navigation
//
//  Created by Oleg Popov on 06.11.2022.
//

import Foundation
import UIKit

class TestUserService: UserService {
    
    let user: User = .init(userName: "Test Person", userAvatar: UIImage(named: "nonePhoto") ?? UIImage(), userStatus: "Test status test")
    
    func returnUser(userName: String) -> User? {
        
       if userName == user.userName {
            return user
        }
            return nil
    }
}
  
