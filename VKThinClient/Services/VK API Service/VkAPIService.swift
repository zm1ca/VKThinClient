//
//  NetworkService.swift
//  VKThinClient
//
//  Created by Źmicier Fiedčanka on 29.06.21.
//

import Foundation
import Moya

enum VkAPIService {
    case getPosts(startingFrom: String?)
    case getProfileInfo
    case getUserAvatar
    case getFriends
    case getSubscriptions
    
    private var authService: AuthService {
        SceneDelegate.shared().authService
    }
    
    private var params: [String: Any] {
        ["access_token": authService.token!, "v": "5.92"]
    }
    
    private func params(appending newParams: [String: Any]) -> [String: Any] {
        var params = params
        newParams.forEach { params[$0] = $1 }
        return params
    }
}

extension VkAPIService: TargetType {
    
    var baseURL: URL { URL(string: "https://api.vk.com")! }
    
    var path: String {
        switch self {
        case .getPosts:         return "/method/newsfeed.get"
        case .getProfileInfo:   return "/method/account.getProfileInfo"
        case .getUserAvatar:    return "/method/users.get"
        case .getFriends:       return "/method/friends.get"
        case .getSubscriptions: return "/method/users.getSubscriptions"
        }
    }
    
    var method: Moya.Method { .get }
    
    var sampleData: Data { Data() }
    
    var task: Task {
        switch self {
        case .getPosts(let offset):
            return .requestParameters(
                parameters: params(appending: ["filters": "post", "count": 20, "start_from": offset as Any]),
                encoding: URLEncoding.queryString
            )
        case .getProfileInfo:
            return .requestParameters(
                parameters: params,
                encoding: URLEncoding.queryString
            )
        case .getUserAvatar:
            return .requestParameters(
                parameters: params(appending: ["user_ids": authService.userId!, "fields": "photo_400_orig"]),
                encoding: URLEncoding.queryString
            )
        case .getFriends:
            return .requestParameters(
                parameters: params,
                encoding: URLEncoding.queryString
            )
        case .getSubscriptions:
            return .requestParameters(
                parameters: params,
                encoding: URLEncoding.queryString
            )
        }
    }
    
    var headers: [String : String]? { nil }
}
