//
//  SecondViewController.swift
//  ys-client-server-1347
//
//  Created by Ярослав on 09.07.2021.
//

import UIKit

class SecondViewController: UIViewController {
    
    let vkService = VKService(session: Session.instance)
    
    let errorMessage = "Ошибка! Что-то пошло не так!"
    
    let searchQuery = "падонки"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        vkService.getUserInfo() { json in
            print("=== Информация обо мне ===")
            print(self.stringify(json ?? self.errorMessage))
        }
        
        vkService.getFriendsList() { json in
            print("=== Список друзей ===")
            print(self.stringify(json ?? self.errorMessage))
        }

        vkService.getPhotos() { json in
            print("=== Мои фотки ===")
            print(self.stringify(json ?? self.errorMessage))
        }

        vkService.getGroups() { json in
            print("=== Мои группы ===")
            print(self.stringify(json ?? self.errorMessage))
        }

        vkService.searchGroups(searchQuery: searchQuery, count: 10) { json in
            print("=== Поиск групп по запросу «\(self.searchQuery)» ===")
            print(self.stringify(json ?? self.errorMessage))
        }
    }
    
    func stringify(_ json: Any) -> String {
        
        let options: JSONSerialization.WritingOptions = [JSONSerialization.WritingOptions.prettyPrinted]

        do {
          let data = try JSONSerialization.data(withJSONObject: json, options: options)
          if let string = String(data: data, encoding: String.Encoding.utf8) {
            return string
          }
        } catch {
          print(error)
        }

        return ""
    }
}
