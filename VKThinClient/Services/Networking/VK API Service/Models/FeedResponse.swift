//
//  FeedModels.swift
//  VKThinClient
//
//  Created by Źmicier Fiedčanka on 29.06.21.
//

import UIKit

protocol VKResponse {}

struct FeedResponseWrapped: Decodable {
    let response: FeedResponse
}

struct FeedResponse: Decodable, VKResponse {
    let items: [Post]
    var profiles: [Profile]
    var groups: [Group]
}

struct Post:     Decodable {
    let sourceId:    Int
    let text:        String?
    let date:        Double
    let comments:    CountaleItem?
    let likes:       CountaleItem?
    let reposts:     CountaleItem?
    let views:       CountaleItem?
    let attachments: [Attechment]?
}

struct CountaleItem: Decodable {
    let count: Int
}

struct Attechment: Decodable {
    let photo: Photo?
}

struct Photo: Decodable {
    let sizes: [PhotoSize]
    
    var height: Int {
         return getPropperSize().height
    }
    
    var width: Int {
        return getPropperSize().width
    }
    
    var srcBIG: String {
         return getPropperSize().url
    }
    
    private func getPropperSize() -> PhotoSize {
        if let sizeX = sizes.first(where: { $0.type == "x" }) {
            return sizeX
        } else if let fallBackSize = sizes.last {
             return fallBackSize
        } else {
            return PhotoSize(type: "wrong image", url: "wrong image", width: 0, height: 0)
        }
    }
    
    var adjustedHeight: Int {
        let compensation = Double(width) / (Double(UIScreen.main.bounds.size.width) - 80)
        return Int(Double(height) / compensation)
    }
}

struct PhotoSize: Decodable {
    let type:   String
    let url:    String
    let width:  Int
    let height: Int
}

protocol ProfileRepresenatable {
    var id:    Int    { get }
    var name:  String { get }
    var photo: String { get }
}

struct Profile: Decodable, ProfileRepresenatable {
    let id:        Int
    let firstName: String
    let lastName:  String
    let photo100:  String
    
    var name: String { firstName + " " + lastName }
    var photo: String { photo100 }
}

struct Group: Decodable, ProfileRepresenatable {
    let id:       Int
    let name:     String
    let photo100: String
    
    var photo: String { photo100 }
}
