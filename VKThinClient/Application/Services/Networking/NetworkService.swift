//
//  NetworkService.swift
//  VKThinClient
//
//  Created by Źmicier Fiedčanka on 29.06.21.
//

import Foundation
import Moya

enum NetworkService {
    case getPosts
    case getUserInfo
    
    private var authService: AuthService {
        SceneDelegate.shared().authService
    }
    
    private var params: [String: String] {
        ["access_token": authService.token!, "v": "5.92"]
    }
    
    private func params(appending newParams: [String: String]) -> [String: String] {
        var params = params
        newParams.forEach { params[$0] = $1 }
        return params
    }
}

extension NetworkService: TargetType {
    
    var baseURL: URL { URL(string: "https://api.vk.com")! }
    
    var path: String {
        switch self {
        case .getPosts:    return "/method/newsfeed.get"
        case .getUserInfo: return "/method/account.getProfileInfo"
        }
    }
    
    var method: Moya.Method { .get }
    
    var sampleData: Data { Data() }
    
    var task: Task {
        switch self {
        case .getPosts:
            return .requestParameters(
                parameters: params(appending: ["filters":"post"]),
                encoding: URLEncoding.queryString
            )
        case .getUserInfo:
            return .requestParameters(
                parameters: params,
                encoding: URLEncoding.queryString
            )
        }
    }
    
    var headers: [String : String]? { nil }
}
