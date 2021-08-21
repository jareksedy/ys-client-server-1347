//
//  PhotoAPI.swift
//  ys-client-server-1347
//
//  Created by Ярослав on 13.07.2021.
//

import Foundation
import Alamofire

class PhotoAPI {
    
    let baseUrl = "https://api.vk.com/method"
    let method = "/photos.getAll"
    
    var params: Parameters
    
    init(_ session: Session) {
        
        self.params = [
            "client_id": session.cliendId,
            "user_id": session.userId,
            "access_token": session.token,
            "v": session.version,
        ]
        
    }
    
    func get(_ completion: @escaping (Photos?) -> ()) {
        
        let url = baseUrl + method
        
        AF.request(url, method: .get, parameters: params).responseData { response in
            
            guard let data = response.data else { return }
            
            do {
                var photos: Photos
                photos = try JSONDecoder().decode(Photos.self, from: data)
                completion(photos)
            } catch {
                print(error)
            }
        }
    }
}
