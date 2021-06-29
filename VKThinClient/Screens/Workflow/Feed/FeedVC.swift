//
//  FeedVC.swift
//  VKThinClient
//
//  Created by Źmicier Fiedčanka on 28.06.21.
//

import UIKit
import Moya

class FeedVC: UIViewController {
    
    var feedProvider = MoyaProvider<NetworkService>()

    override func viewDidLoad() {
        super.viewDidLoad()
        testGettingFeed()
        testGettingUserInfo()
    }
    
    private func testGettingFeed() {
        feedProvider.request(.getPosts) { result in
            switch result {
            case .success(let response):
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let response = try? decoder.decode(FeedResponseWrapped.self, from: response.data)
                response?.response.items.forEach { feedItem in
                    print(feedItem.text)
                }
                
            case .failure(let error):
                print("Networking failed with", error.localizedDescription)
            }
        }
    }
    
    private func testGettingUserInfo() {
        feedProvider.request(.getUserInfo) { result in
            switch result {
            case .success(let response):
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let response = try? decoder.decode(ProfileInfoWrapped.self, from: response.data)
                print(response)
            case .failure(let error):
                print("Networking failed with", error.localizedDescription)
            }
        }
    }
}
