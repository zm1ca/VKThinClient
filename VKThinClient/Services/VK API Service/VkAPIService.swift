//
//  NetworkService.swift
//  VKThinClient
//
//  Created by Źmicier Fiedčanka on 29.06.21.
//

import Foundation
import Moya

enum VkAPIService {
    case getPosts
    case getProfileInfo
    case getUserAvatar
    
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
        }
    }
    
    var method: Moya.Method { .get }
    
    var sampleData: Data { Data() }
    
    var task: Task {
        switch self {
        case .getPosts:
            return .requestParameters(
                parameters: params(appending: ["filters": "post", "count": 20]),
                encoding: URLEncoding.queryString
            )
        case .getProfileInfo:
            return .requestParameters(
                parameters: params,
                encoding: URLEncoding.queryString
            )
        case .getUserAvatar:
            return .requestParameters(
                parameters: params(appending: ["user_ids": authService.userId!, "fields": "photo_100"]),
                encoding: URLEncoding.queryString
            )
        }
    }
    
    var headers: [String : String]? { nil }
}
