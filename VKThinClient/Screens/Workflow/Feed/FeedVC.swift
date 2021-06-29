//
//  FeedVC.swift
//  VKThinClient
//
//  Created by Źmicier Fiedčanka on 28.06.21.
//

import UIKit

class FeedVC: UIViewController {

    private var fetcher: DataFetcher = NetworkDataFetcher(networking: NetworkService())

    override func viewDidLoad() {
        super.viewDidLoad()
        fetcher.getFeed { response in
            guard let response = response else { return }
            response.items.map { feedItem in
                print(feedItem.postId, feedItem.text, feedItem.likes?.count)
            }
        }
    }
}
