//
//  FriendViewModelFactory.swift
//  ys-client-server-1347
//
//  Created by Ярослав on 26.09.2021.
//

import Foundation
import UIKit

final class FriendViewModelFactory {
    
    func constructViewModels(from friends: [FriendItem]) -> [FriendViewModel] {
        return friends.compactMap(self.viewModel)
    }
    
    private func viewModel(from friend: FriendItem) -> FriendViewModel {
        
        var lastSeen = ""
        var statusColor = UIColor.systemGreen
        
        let fullName = "\(friend.firstName) \(friend.lastName)"
        
        var friendFemale: Bool {
            switch friend.sex {
            case 2:
                return false
            case 1:
                return true
            default:
                return false
            }
        }
        
        if friend.online == 1 {
            lastSeen = "Онлайн"
            statusColor = UIColor.systemGreen
        } else {
            lastSeen = friendFemale ? "Была " : "Был "
            lastSeen += friend.lastSeen?.time.getRelativeDateStringFromUTC().lowercased() ?? ""
            statusColor = UIColor.secondaryLabel
        }
        
        let imageUrl = friend.photo100 != nil ? friend.photo100! : "https://pmdoc.ru/wp-content/uploads/default-avatar.png"
        
        return FriendViewModel(fullName: fullName,
                               imageUrl: imageUrl,
                               lastSeen: lastSeen,
                               statusColor: statusColor,
                               id: friend.id)
    }
}
