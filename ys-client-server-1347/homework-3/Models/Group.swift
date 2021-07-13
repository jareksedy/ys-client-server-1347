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
struct GroupItem: Codable {
    let id: Int
    let name: String
    let groupDescription: String?
    let photo100: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case groupDescription = "description"
        case photo100 = "photo_100"
    }
}
