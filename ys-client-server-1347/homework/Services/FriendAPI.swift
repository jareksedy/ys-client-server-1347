//
//  FriendAPI.swift
//  ys-client-server-1347
//
//  Created by Ярослав on 27.08.2021.
//

import Foundation
import Alamofire

protocol FriendAPIInterface {
    var request: String? { get }
    func get(_ completion: @escaping (Friends?) -> ())
    func removeFromFriends(_ id: Int, _ completion: @escaping (FriendDelete?) -> ())
}

class FriendAPIProxy: FriendAPIInterface {
    var request: String?
    let friendAPI: FriendAPIInterface
    
    init(friendAPI: FriendAPIInterface) {
        self.friendAPI = friendAPI
    }
    
    func get(_ completion: @escaping (Friends?) -> ()) {
        friendAPI.get { [weak self] friends in
            guard self != nil else { return }
            print("PROXY LOG REQUEST: \(self?.friendAPI.request ?? "UNKNOWN")")
            completion(friends)
        }
    }
    
    func removeFromFriends(_ id: Int, _ completion: @escaping (FriendDelete?) -> ()) {
        friendAPI.removeFromFriends(id) { friendDelete in
            print("PROXY LOG REQUEST: \(self.friendAPI.request ?? "UNKNOWN")")
            completion(friendDelete)
        }
    }
    
    
}

class FriendAPI: FriendAPIInterface {
    
    let baseUrl = "https://api.vk.com/method"
    var params: Parameters
    var request: String?
    
    init() {
        
        self.params = [
            "client_id": Session.instance.cliendId,
            "user_id": Session.instance.userId,
            "access_token": Session.instance.token,
            "v": Session.instance.version,
        ]
    }
    
    func get(_ completion: @escaping (Friends?) -> ()) {
        
        let method = "/friends.get"
        let url = baseUrl + method
        
        params["extended"] = "1"
        params["fields"] = "photo_100,online,sex,last_seen"
        
        AF.request(url, method: .get, parameters: params).responseData{ response in
            self.request = response.request?.description
            
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
        
        AF.request(url, method: .get, parameters: params).responseData { response in
            self.request = response.request?.description
            
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
