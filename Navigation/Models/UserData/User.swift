//
//  User.swift
//  Navigation
//
//  Created by Oleg Popov on 15.10.2022.
//

import Foundation
import UIKit


final class User {

    let userName : String
    let userAvatar : UIImage
    let userStatus : String
    
    init(userName: String, userAvatar: UIImage, userStatus: String) {
        
        self.userName = userName
        self.userAvatar = userAvatar
        self.userStatus = userStatus
    }
}




