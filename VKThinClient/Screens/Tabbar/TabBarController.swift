//
//  TabbarController.swift
//  VKThinClient
//
//  Created by Źmicier Fiedčanka on 28.06.21.
//

import UIKit

class TabBarController: UITabBarController {

    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        self.selectedIndex = 1
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        ImageLoader.shared.saveCache()
    }
}
