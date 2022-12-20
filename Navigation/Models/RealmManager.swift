//
//  RealmManager.swift
//  Navigation
//
//  Created by Oleg Popov on 20.12.2022.
//

import Foundation
import UIKit
import RealmSwift


class RealmUsers: Object {
    
    @Persisted (primaryKey: true) var primaryKey: ObjectId
    
    @Persisted var login: String
    @Persisted var password: String
    
    
    convenience init(login: String, password: String) {
        self.init()
        self.login = login
        self.password = password
    }
}

class RealmManager {
    
    var realm = try! Realm()
    var realmUsers: [RealmUsers] = []
    
    func reloadUserBase() {
        realmUsers = Array(realm.objects(RealmUsers.self))
    }
    
    func saveRealmUser (login: String, password: String) {
        try! realm.write {
            let users = RealmUsers(login: login, password: password)
            realm.add(users)
        }
    }
}
