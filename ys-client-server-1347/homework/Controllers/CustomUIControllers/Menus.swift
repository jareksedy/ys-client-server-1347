//
//  Menus.swift
//  ys-client-server-1347
//
//  Created by Ярослав on 01.09.2021.
//

import Foundation
import UIKit

// MARK: - Friend cell menu.

var friendsMenuItems: [UIAction]  = [
    UIAction(title: "Удалить нахрен из друзей", image: UIImage(systemName: "trash"), attributes: .destructive, handler: { _ in
        
//        let alert = UIAlertController(title: "Удалить из друзей",
//                                      message: "Вы действительно хотите удалить нахрен из друзей?",
//                                      preferredStyle: .alert)
//
//        alert.addAction(UIAlertAction(title: "Да", style: .default, handler: nil))
//        alert.addAction(UIAlertAction(title: "Нет", style: .cancel, handler: nil))
//
//        alert.present(alert, animated: true)
        
        print("hello \(100)")
        
    }),
]

let friendsMenu = UIMenu(children: friendsMenuItems)
