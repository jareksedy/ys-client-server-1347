//
//  Group.swift
//  ys-client-server-1347
//
//  Created by Ярослав on 13.07.2021.
//

import Foundation

// MARK: - Main
struct Groups: Codable {
    let response: Response
}

// MARK: - Response
struct Response: Codable {
    let count: Int
    let items: [GroupItem]
}

// MARK: - Item
class GroupItem: Codable {
    var id: Int = 0
    var name: String = ""
    var groupDescription: String?
    var imageURL: String = ""
    var membersCount: Int = 0

    enum CodingKeys: String, CodingKey {
        case id, name
        case groupDescription = "description"
        case imageURL = "photo_100"
        case membersCount = "members_count"
    }
}
