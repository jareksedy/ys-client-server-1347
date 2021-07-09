//
//  VKService.swift
//  ys-client-server-1347
//
//  Created by Ярослав on 09.07.2021.
//

import Foundation

class VKService {
    
    let VKSession = URLSession(configuration: .default)
    
    var VKURLComponents = URLComponents()
    let scheme = "https"
    let host = "api.vk.com"
    let path = "/method"
    
    let client_id = "7899606"
    
    init(session: Session) {
        
        self.VKURLComponents.scheme = scheme
        self.VKURLComponents.host = host
        self.VKURLComponents.queryItems = [
            URLQueryItem(name: "client_id", value: client_id),
            URLQueryItem(name: "user_id", value: "\(session.userId)"),
            URLQueryItem(name: "access_token", value: "\(session.token)"),
            URLQueryItem(name: "v", value: "5.68"),
        ]
    }
    
    func getUserInfo(completion: @escaping (Any?) -> ()) {
        
        VKURLComponents.path = path + "/users.get"
        perform(VKURLComponents, completion)
    }
    
    func getFriendsList(completion: @escaping (Any?) -> ()) {
        
        VKURLComponents.path = path + "/friends.get"
        VKURLComponents.queryItems?.append(URLQueryItem(name: "fields", value: "nickname, city, country, sex"))
        perform(VKURLComponents, completion)
    }
    
    func getPhotos(completion: @escaping (Any?) -> ()) {
        
        VKURLComponents.path = path + "/photos.getAll"
        VKURLComponents.queryItems?.append(URLQueryItem(name: "no_service_albums", value: "0"))
        perform(VKURLComponents, completion)
    }
    
    func getGroups(completion: @escaping (Any?) -> ()) {
        
        VKURLComponents.path = path + "/groups.get"
        VKURLComponents.queryItems?.append(URLQueryItem(name: "extended", value: "1"))
        VKURLComponents.queryItems?.append(URLQueryItem(name: "fields", value: "description, members_count"))
        perform(VKURLComponents, completion)
    }
    
    func searchGroups(searchQuery: String, count: Int = 5, completion: @escaping (Any?) -> ()) {
        
        VKURLComponents.path = path + "/groups.search"
        VKURLComponents.queryItems?.append(URLQueryItem(name: "q", value: searchQuery))
        VKURLComponents.queryItems?.append(URLQueryItem(name: "type", value: "group"))
        VKURLComponents.queryItems?.append(URLQueryItem(name: "count", value: "\(count)"))
        perform(VKURLComponents, completion)
    }
    
    private func perform(_ urlComponents: URLComponents, _ completion: @escaping (Any?) -> ()) {
        let task = VKSession.dataTask(with: urlComponents.url!) {(data, response, error) in
            let json = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
            completion(json ?? nil)
        }
        task.resume()
    }
}
