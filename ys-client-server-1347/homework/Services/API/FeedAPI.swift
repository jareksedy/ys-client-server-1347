//
//  FeedAPI.swift
//  ys-client-server-1347
//
//  Created by Ярослав on 07.08.2021.
//

import Foundation
import Alamofire
import SwiftyJSON

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
            //"count": "1",
        ]
        
    }
    
    func get(_ completion: @escaping (Feed?) -> ()) {
        
        let url = baseUrl + method
        
        AF.request(url, method: .get, parameters: params).responseData { response in
            
            guard let data = response.data else { return }
            
            let decoder = JSONDecoder()
            let json = JSON(data)
            let vkItemsJSONArr = json["response"]["items"].arrayValue
            //let vkProfilesJSONArr = json["response"]["profiles"].arrayValue
            //let vkGroupsJSONArr = json["response"]["groups"].arrayValue
            
            var vkItemsArray: [Item] = []
            
            for (index, items) in vkItemsJSONArr.enumerated() {
                do {
                    let decodedItem = try decoder.decode(Item.self, from: items.rawData())
                    vkItemsArray.append(decodedItem)
                    
                } catch(let errorDecode) {
                    print("Item decoding error at index \(index), err: \(errorDecode)")
                }
            }
            print(vkItemsArray.count)
            
            
//            do {
//                var feed: Feed
//                feed = try JSONDecoder().decode(Feed.self, from: data)
//                completion(feed)
//            } catch {
//                print(error)
//            }
            
        }
    }
}
