//
//  User.swift
//  ys-client-server-1347
//
//  Created by Ярослав on 13.07.2021.
//

import Foundation


struct User: Codable {
    let response: [UserResponse]
}

// MARK: - Response
struct UserResponse: Codable {
    let id: Int
    let firstName: String
    let lastName: String
    let city, country: Location
    let photo200: String?
    let hasPhoto: Int

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case city, country
        case photo200 = "photo_200"
        case hasPhoto = "has_photo"
    }
}

// MARK: - City
struct Location: Codable {
    let id: Int
    let title: String
}
