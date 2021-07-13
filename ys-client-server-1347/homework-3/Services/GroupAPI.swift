//
//  GroupAPI.swift
//  ys-client-server-1347
//
//  Created by Ярослав on 13.07.2021.
//

import Foundation
import Alamofire

// === СПИСОК ГРУПП (КОДАБЛ) ===

class GroupAPI {
    
    let baseUrl = "https://api.vk.com/method"
    let method = "/groups.get"
    
    let cliendId = "7902471"
    let version = "5.68"
    
    var params: Parameters
    
    init(_ session: Session) {
        
        self.params = [
            "client_id": self.cliendId,
            "user_id": session.userId,
            "access_token": session.token,
            "v": self.version,
            "extended": "1",
            "fields": "description, members_count",
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
