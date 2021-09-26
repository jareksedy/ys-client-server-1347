//
//  UserViewModelFactory.swift
//  ys-client-server-1347
//
//  Created by Ярослав on 26.09.2021.
//

import Foundation

final class UserViewModelFactory {
    
    func constructViewModels(from user: User) -> UserViewModel {
        return self.viewModel(from: user)
    }
    
    private func viewModel(from user: User) -> UserViewModel {
        
        let fullName = "\(user.response[0].firstName) \(user.response[0].lastName)"
        let location = "\(user.response[0].city.title), \(user.response[0].country.title)."
        let userImageUrl = user.response[0].photo200 != nil ? user.response[0].photo200! : "https://pmdoc.ru/wp-content/uploads/default-avatar.png"
        
        return UserViewModel(fullName: fullName, location: location, userImageUrl: userImageUrl)
    }
}
