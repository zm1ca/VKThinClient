//
//  FeedVC.swift
//  VKThinClient
//
//  Created by Źmicier Fiedčanka on 28.06.21.
//

import UIKit

class FeedVC: UIViewController {
    
    let networkService = NetworkService()

    override func viewDidLoad() {
        super.viewDidLoad()
        networkService.request(path: "/method/newsfeed.get", params: ["filters":"post"]) { data, error in
            print(data)
        }
    }
}
