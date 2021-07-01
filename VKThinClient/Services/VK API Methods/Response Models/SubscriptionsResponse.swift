//
//  SubscriptionsResponse.swift
//  VKThinClient
//
//  Created by Źmicier Fiedčanka on 30.06.21.
//

import Foundation

struct SubscriptionsResponseWrapped: Decodable {
    let response: SubscriptionsResponse
}

struct SubscriptionsResponse: Decodable {
    let groups: GroupResponse
}

struct GroupResponse: Decodable {
    let count: Int
}
