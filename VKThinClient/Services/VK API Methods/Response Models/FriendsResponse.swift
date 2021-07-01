//
//  FriendsResponse.swift
//  VKThinClient
//
//  Created by Źmicier Fiedčanka on 30.06.21.
//

import Foundation

struct FriendResponseWrapped: Decodable {
    let response: FriendsResponse
}

struct FriendsResponse: Decodable {
    let count: Int
}
