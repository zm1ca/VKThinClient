//
//  ProfileInfo.swift
//  VKThinClient
//
//  Created by Źmicier Fiedčanka on 29.06.21.
//

import Foundation

struct ProfileInfoWrapped: Decodable {
    let response: ProfileResponse
}

struct ProfileResponse: Decodable {
    let firstName: String
    let lastName:  String
    let id:        Int
    let sex:       Int
    let relation:  Int
    let bdate:     String
    let homeTown:  String
    
    var name: String { firstName + " " + lastName }
}
