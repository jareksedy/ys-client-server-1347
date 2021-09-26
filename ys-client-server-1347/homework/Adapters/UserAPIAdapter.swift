//
//  UserAPIAdapter.swift
//  ys-client-server-1347
//
//  Created by Ярослав on 26.09.2021.
//

import Foundation

final class UserAPIAdapter {
    
    private let api = UserAPI()
    private var user: User?
    
    func get(_ completion: @escaping (User?) -> ()) {
        completion(api.get())
    }
}
