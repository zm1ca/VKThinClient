//
//  FeedResponse.swift
//  VKThinClient
//
//  Created by Źmicier Fiedčanka on 29.06.21.
//

import Foundation

struct FeedResponseWrapped: Decodable {
    let response: FeedResponse
}

struct FeedResponse: Decodable {
    let items: [FeedItem]
}

struct FeedItem: Decodable {
    let sourceId: Int
    let postId: Int
    let text: String?
    let date: Double
    let comments: CountaleItem?
    let likes: CountaleItem?
    let reposts: CountaleItem?
    let views: CountaleItem?
}

struct CountaleItem: Decodable {
    let count: Int
}
