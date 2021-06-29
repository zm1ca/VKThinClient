//
//  DataFetchingService.swift
//  VKThinClient
//
//  Created by Źmicier Fiedčanka on 29.06.21.
//

import Foundation
import Moya

class DataFetchingService {
    
    let feedProvider = MoyaProvider<NetworkService>()
    
    func getPosts(completion: @escaping (FeedResponse?) -> Void) {
        feedProvider.request(.getPosts) { result in
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
    
    ///TODO: fix code duplication by adding protocol WrappedResponse with var response and associatedType
    ///Consider creating two data Fetchers: for feed and profile, united by protocol DataFetcher
    func getProfileInfo(completion: @escaping (ProfileResponse?) -> Void) {
        feedProvider.request(.getUserInfo) { result in
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
    
    func getUserAvatar(completion: @escaping (UserResponse?) -> Void) {
        feedProvider.request(.getUserAvatar) { result in
            switch result {
            case .success(let response):
                let response = self.decodeJSON(
                    type: UserResponseWrapped.self,
                    from: response.data
                )
                completion(response?.response.first)
            case .failure(_):
                completion(nil)
            }
        }
    }
    
    private func decodeJSON<T: Decodable>(type: T.Type, from data: Data?) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let data = data, let response = try? decoder.decode(type, from: data) else { return nil }
        return response
    }
}

