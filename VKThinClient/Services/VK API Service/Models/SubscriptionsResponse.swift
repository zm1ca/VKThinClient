//
//  SubscriptionsResponse.swift
//  VKThinClient
//
//  Created by Źmicier Fiedčanka on 30.06.21.
//

import Foundation

struct SubscriptionsResponseWrapped: Decodable {
    let response: FriendsResponse
}

struct SubscriptionsResponse: Decodable {
    let count: Int
}
