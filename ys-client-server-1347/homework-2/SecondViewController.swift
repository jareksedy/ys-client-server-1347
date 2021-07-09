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
            print(json ?? self.errorMessage)
        }
        
        vkService.getFriendsList() { json in
            print("=== Список друзей ===")
            print(json ?? self.errorMessage)
        }
        
        vkService.getPhotos() { json in
            print("=== Мои фотки ===")
            print(json ?? self.errorMessage)
        }
        
        vkService.getGroups() { json in
            print("=== Мои группы ===")
            print(json ?? self.errorMessage)
        }
        
        vkService.searchGroups(searchQuery: searchQuery, count: 1) { json in
            print("=== Поиск групп по запросу «\(self.searchQuery)» ===")
            print(json ?? self.errorMessage)
        }
    }
}
