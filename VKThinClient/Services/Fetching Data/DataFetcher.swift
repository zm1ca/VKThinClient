//
//  DataFetcher.swift
//  VKThinClient
//
//  Created by Źmicier Fiedčanka on 29.06.21.
//

import Foundation
import Moya

///TODO: fix code duplication by adding protocol WrappedResponse with var response and associatedType
///Consider creating two data Fetchers: for feed and profile, united by protocol DataFetcher
class DataFetcher {
    
    let feedProvider = MoyaProvider<VkAPIService>()
    
    func getPosts(startingFrom offset: String?, completion: @escaping (FeedResponse?) -> Void) {
        feedProvider.request(.getPosts(startingFrom: offset)) { result in
            switch result {
            case .success(let response):
                let wrappedResponse = self.decodeJSON(
                    type: FeedResponseWrapped.self,
                    from: response.data
                )
                completion(wrappedResponse?.response)
            case .failure(_):
                completion(nil)
            }
        }
    }
    
    func getProfileInfo(completion: @escaping (ProfileResponse?) -> Void) {
        feedProvider.request(.getProfileInfo) { result in
            switch result {
            case .success(let response):
                let response = self.decodeJSON(
                    type: ProfileInfoWrapped.self,
                    from: response.data
                )
                completion(response?.response)
            case .failure(_):
                completion(nil)
            }
        }
    }
    
    func getUserAvatar(completion: @escaping (AvatarResponse?) -> Void) {
        feedProvider.request(.getUserAvatar) { result in
            switch result {
            case .success(let response):
                let response = self.decodeJSON(
                    type: AvatarResponseWrapped.self,
                    from: response.data
                )
                completion(response?.response.first)
            case .failure(_):
                completion(nil)
            }
        }
    }
    
    func getFriendsCount(completion: @escaping (Int?) -> Void) {
        feedProvider.request(.getFriends) { result in
            switch result {
            case .success(let response):
                let response = self.decodeJSON(
                    type: FriendResponseWrapped.self,
                    from: response.data
                )
                completion(response?.response.count)
            case .failure(_):
                completion(nil)
            }
        }
    }
    
    func getSubscriptionsCount(completion: @escaping (Int?) -> Void) {
        feedProvider.request(.getSubscriptions) { result in
            switch result {
            case .success(let response):
                let response = self.decodeJSON(
                    type: SubscriptionsResponseWrapped.self,
                    from: response.data
                )
                completion(response?.response.count)
            case .failure(_):
                completion(nil)
            }
        }
    }
}

extension DataFetcher {
    func decodeJSON<T: Decodable>(type: T.Type, from data: Data?) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let data = data, let response = try? decoder.decode(type, from: data) else { return nil }
        return response
    }
}

