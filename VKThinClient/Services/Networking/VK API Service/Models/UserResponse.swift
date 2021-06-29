//
//  UserAvatar.swift
//  VKThinClient
//
//  Created by Źmicier Fiedčanka on 29.06.21.
//

import Foundation

struct UserResponseWrapped: Decodable {
    let response: [UserResponse]
}

struct UserResponse: Decodable, VKResponse {
    let photo100: String?
}
