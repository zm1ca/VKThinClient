//
//  FeedVC.swift
//  VKThinClient
//
//  Created by Źmicier Fiedčanka on 28.06.21.
//

import UIKit
import Moya

class FeedVC: UIViewController {
    
    let dataFetcher = DataFetchingService()

    override func viewDidLoad() {
        super.viewDidLoad()
        dataFetcher.getPosts { feedResponse in
            guard let feed = feedResponse else { print("Failed to get feed"); return }
            feed.items.forEach { print($0.text!) }
        }
    }

}
