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
    
    var params: Parameters
    
    init(_ session: Session) {
        
        self.params = [
            "client_id": session.cliendId,
            "user_id": session.userId,
            "access_token": session.token,
            "v": "5.80",
        ]
        
    }
    
    func get(_ completion: @escaping (Friends?) -> ()) {
        
        let method = "/friends.get"
        let url = baseUrl + method
        
        params["extended"] = "1"
        params["fields"] = "photo_100,online,sex,last_seen"
        
        AF.request(url, method: .get, parameters: params).responseData{ response in
            
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
    
    func removeFromFriends(_ id: Int, _ completion: @escaping (FriendDelete?) -> ()) {
        
        let method = "/friends.delete"
        let url = baseUrl + method
        
        params["user_id"] = "\(id)"
        
        AF.request(url, method: .get, parameters: params).responseData{ response in
            
            guard let data = response.data else { return }
            
            do {
                var friendDelete: FriendDelete
                friendDelete = try JSONDecoder().decode(FriendDelete.self, from: data)
                completion(friendDelete)
            } catch {
                print(error)
            }
        }
    }
}
