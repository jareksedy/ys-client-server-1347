//
//  UserAPI.swift
//  ys-client-server-1347
//
//  Created by Ярослав on 13.07.2021.
//

import Foundation
import Alamofire

// === ИНФО О ПОЛЬЗОВАТЕЛЕ (РУЧНОЙ ПАРСИНГ) ===

class UserAPI {
    
    let baseUrl = "https://api.vk.com/method"
    let method = "/users.get"
    
    var params: Parameters
    
    init(_ session: Session) {
        
        self.params = [
            "client_id": session.cliendId,
            "user_id": session.userId,
            "access_token": session.token,
            "v": session.version,
            "fields": "has_photo, photo_200, city, country",
        ]
        
    }
    
    func get(_ completion: @escaping (User?) -> ()) {
        
        let url = baseUrl + method
        
        AF.request(url, method: .get, parameters: params).responseData { response in
            
            guard let data = response.data else { return }
            
            do {
                let json: Any = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                let object = json as! [String: Any]
                let response = object["response"] as! [Any]
                let data = response[0] as! [String: Any]
                let city = data["city"] as! [String: Any]
                let country = data["country"] as! [String: Any]
                
                let user = User(id: data["id"] as! Int,
                                firstName: data["first_name"] as! String,
                                lastName: data["last_name"] as! String,
                                imageURL: data["photo_200"] as? String,
                                country: country["title"] as! String,
                                city: city["title"] as! String)
                
                completion(user)
                
            }
            catch {
                print(error)
            }
        }
    }
}
