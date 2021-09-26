//
//  UserAPI.swift
//  ys-client-server-1347
//
//  Created by Ярослав on 13.07.2021.
//

import Foundation

class UserAPI {
    
    let baseUrl = "https://api.vk.com/method"
    let method = "/users.get"
    
    enum Errors: Error {
        case unknownError
        case noPhotoUrl
    }
    
//  var params: Parameters
    
    init() {
        
//        self.params = [
//            "client_id": Session.instance.cliendId,
//            "user_id": Session.instance.userId,
//            "access_token": Session.instance.token,
//            "v": Session.instance.version,
//            "fields": "has_photo, photo_200, city, country",
//        ]
        
    }
    
    func get() -> User? {
        
        let url = baseUrl + method + "?client_id=\(Session.instance.cliendId)&user_id=\(Session.instance.userId)&access_token=\(Session.instance.token)&v=\(Session.instance.version)&fields=has_photo,photo_200,city,country"
        let finalUrl = URL(string: url)!
        
        var user: User?
        
        do { let data = try Data(contentsOf: finalUrl)
            do { user = try JSONDecoder().decode(User.self, from: data)
            } catch { print(error) }
        } catch { print(error) }
        
        return user
    }
}
