//
//  FeedAPI.swift
//  ys-client-server-1347
//
//  Created by Ярослав on 07.08.2021.
//

import Foundation
import Alamofire

// === ЛЕНТА НОВОСТЕЙ ===

class FeedAPI {
    
    let baseUrl = "https://api.vk.com/method"
    let method = "/newsfeed.get"
    
    var params: Parameters
    
    init(_ session: Session) {
        
        self.params = [
            "client_id": session.cliendId,
            "user_id": session.userId,
            "access_token": session.token,
            "v": session.version,
            "filters": "post",
        ]
        
    }
    
    func get(_ completion: @escaping (Groups?) -> ()) {
        
        let url = baseUrl + method
        
        AF.request(url, method: .get, parameters: params).responseData { response in
            
            guard let data = response.data else { return }
            
            do {
                var groups: Groups
                groups = try JSONDecoder().decode(Groups.self, from: data)
                completion(groups)
            } catch {
                print(error)
            }
            
        }
    }
}
