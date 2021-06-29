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
    @IBOutlet weak var tableView: UITableView!
    
    var posts = [Post]()
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = #colorLiteral(red: 0.9567961097, green: 0.9567961097, blue: 0.9567961097, alpha: 1)
        view.bringSubviewToFront(activityIndicator)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.visibleViewController?.title = "Feed"
        activityIndicator.startAnimating()
        dataFetcher.getPosts { feedResponse in
            guard let feed = feedResponse else {
                self.presentAlertOnMainThread(withTitle: "Networking Error", andMessage: "Unable to load feed")
                return
            }
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.posts = feed.items
                self.tableView.reloadData()
            }
        }
    }
}

extension FeedVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as! FeedCell
        let post = posts[indexPath.row]
        cell.set(with: post)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let text = posts[indexPath.row].text else { return 0 }
        return text.height(font: UIFont.systemFont(ofSize: 17, weight: .regular)) + 140
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        UIView()
    }
}
