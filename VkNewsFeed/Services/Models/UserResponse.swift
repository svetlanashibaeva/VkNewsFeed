//
//  UserResponse.swift
//  VkNewsFeed
//
//  Created by Света Шибаева on 13.12.2022.
//

import Foundation

struct UserResponseWrapped: Decodable {
    let response: [UserResponse]
}

struct UserResponse: Decodable {
    let photo100: String?
    let firstName: String?
    let lastName: String?
}
