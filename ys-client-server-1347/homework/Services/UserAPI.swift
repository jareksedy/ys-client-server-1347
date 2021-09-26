//
//  UserAPI.swift
//  ys-client-server-1347
//
//  Created by Ярослав on 13.07.2021.
//

import Foundation
import Alamofire

class UserAPI {
    
    let baseUrl = "https://api.vk.com/method"
    let method = "/users.get"
    
    enum Errors: Error {
        case unknownError
        case noPhotoUrl
    }
    
    var params: Parameters
    
    init() {
        
        self.params = [
            "client_id": Session.instance.cliendId,
            "user_id": Session.instance.userId,
            "access_token": Session.instance.token,
            "v": Session.instance.version,
            "fields": "has_photo, photo_200, city, country",
        ]
        
    }
    
    func get(_ completion: @escaping (User?) -> ()) {
        
        let url = baseUrl + method
        
        AF.request(url, method: .get, parameters: params).responseData { response in
            
            guard let data = response.data else { return }
            
            do {
                var user: User
                user = try JSONDecoder().decode(User.self, from: data)
                completion(user)
            } catch {
                print(error)
            }
        }
    }
}
