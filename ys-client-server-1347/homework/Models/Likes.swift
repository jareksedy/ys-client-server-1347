//
//  Likes.swift
//  ys-client-server-1347
//
//  Created by Ярослав on 29.08.2021.
//

import Foundation

// MARK: - Likes
struct Likes: Codable {
    let response: Response
}

// MARK: - Response
struct Response: Codable {
    let likes: Int
}
