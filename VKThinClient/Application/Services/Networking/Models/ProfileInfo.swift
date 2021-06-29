//
//  ProfileInfo.swift
//  VKThinClient
//
//  Created by Źmicier Fiedčanka on 29.06.21.
//

import Foundation

struct ProfileInfoWrapped: Decodable {
    let response: ProfileInfo
}

struct ProfileInfo: Decodable {
    let firstName: String
    let lastName:  String
    let id:        Int
    let sex:       Int
    let phone:     String
    let relation:  Int
}
