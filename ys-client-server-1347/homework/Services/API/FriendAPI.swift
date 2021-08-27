//
//  FriendAPI.swift
//  ys-client-server-1347
//
//  Created by Ярослав on 27.08.2021.
//

import Foundation
import Alamofire

class FriendAPI {
    
    let baseUrl = "https://api.vk.com/method"
    let method = "/friends.get"
    
    var params: Parameters
    
    init(_ session: Session) {
        
        self.params = [
            "client_id": session.cliendId,
            "user_id": session.userId,
            "access_token": session.token,
            "v": "5.80",
            "extended": "1",
            "fields": "photo_100,online,last_seen",
        ]
        
    }
    
    func get(_ completion: @escaping (Friends?) -> ()) {
        
        let url = baseUrl + method
        
        AF.request(url, method: .get, parameters: params).responseData { response in
            
            guard let data = response.data else { return }

            do {
                var friends: Friends
                friends = try JSONDecoder().decode(Friends.self, from: data)
                completion(friends)
            } catch {
                print(error)
            }
            
        }
    }
}
