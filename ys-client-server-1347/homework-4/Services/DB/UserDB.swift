//
//  UserDB.swift
//  ys-client-server-1347
//
//  Created by Ярослав on 23.07.2021.
//

import Foundation
import RealmSwift

protocol UserDBProtocol {
    
    func get() -> User?
    func add(_ user: User)
}

class UserDB: UserDBProtocol {
    let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
    lazy var mainRealm = try! Realm(configuration: config)
    
    func get() -> User? {
        
        let user = mainRealm.objects(User.self)
        return user.count > 0 ? Array(user)[0] : nil
    }
    
    func add(_ user: User) {
        
        do {
            mainRealm.beginWrite()
            mainRealm.add(user, update: .all)
            try mainRealm.commitWrite()
            
        } catch {
            print(error)
        }
    }
}
