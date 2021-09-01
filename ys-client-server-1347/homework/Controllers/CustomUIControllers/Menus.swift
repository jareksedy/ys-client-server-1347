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
    UIAction(title: "Просмотреть профиль", image: UIImage(systemName: "doc.plaintext"), handler: { _ in }),
    UIAction(title: "Удалить из друзей", image: UIImage(systemName: "heart.slash"), attributes: .destructive, handler: { _ in }),
]

let friendsMenu = UIMenu(children: friendsMenuItems)
