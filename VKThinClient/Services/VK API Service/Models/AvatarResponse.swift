//
//  UserAvatar.swift
//  VKThinClient
//
//  Created by Źmicier Fiedčanka on 29.06.21.
//

import Foundation

struct AvatarResponseWrapped: Decodable {
    let response: [AvatarResponse]
}

struct AvatarResponse: Decodable {
    let photo100: String?
}
