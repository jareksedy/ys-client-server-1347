//
//  PhotoAPI.swift
//  ys-client-server-1347
//
//  Created by Ярослав on 13.07.2021.
//

import Foundation
import Alamofire

// === Фотки (DynamicJSON) ===

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
    
    func get(_ completion: @escaping ([PhotoItem]?) -> ()) {
        
        let url = baseUrl + method
        
        AF.request(url, method: .get, parameters: params).responseData { response in
            
            guard let data = response.data else { return }
            guard let items = JSON(data).response.items.array else { return }
            
            let photos = items.map {
                PhotoItem(id: $0.id.int!,
                          albumID: $0.album_id.int!,
                          ownerID: $0.owner_id.int!,
                          width: $0.width.int!,
                          height: $0.height.int!,
                          photo75: $0.photo_75.string!,
                          photo130: $0.photo_130.string!,
                          photo604: $0.photo_604.string!,
                          photo807: $0.photo_807.string!,
                          photo1280: $0.photo_1280.string!,
                          text: $0.text.string!)
            }
            
            completion(photos)
        }
    }
}
