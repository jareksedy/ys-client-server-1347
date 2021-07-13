//
//  UserAPI.swift
//  ys-client-server-1347
//
//  Created by Ярослав on 13.07.2021.
//

import Foundation
import Alamofire

// === РУЧНОЙ ПАРСИНГ ===

class UserAPI {
    
    let baseUrl = "https://api.vk.com/method"
    let method = "/users.get"
    
    let cliendId = "7899606"
    let version = "5.68"
    
    var params: Parameters
    
    init(_ session: Session) {
        
        self.params = [
            "client_id": self.cliendId,
            "user_id": session.userId,
            "access_token": session.token,
            "v": self.version,
            
            "fields": "has_photo, photo_200, city, country",
        ]
        
    }
    
    func get() -> User? {
        
        let url = baseUrl + method
        
        AF.request(url, method: .get, parameters: params).responseData { response in
            guard let data = response.data else { return }
            //print(response.request as Any)
        }
        
        return nil
    }
    
}
