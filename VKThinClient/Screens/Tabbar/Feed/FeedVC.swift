//
//  FeedVC.swift
//  VKThinClient
//
//  Created by Źmicier Fiedčanka on 28.06.21.
//

import UIKit
import Moya

class FeedVC: UIViewController {
    
    var posts    = [Post]()
    var groups   = [Group]()
    var profiles = [Profile]()
    
    let dataFetcher = DataFetchingService()
    
    @IBOutlet weak var tableView: UITableView!
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
            
            self.activityIndicator.stopAnimating()
            self.posts    = feed.items
            self.groups   = feed.groups
            self.profiles = feed.profiles
            
            DispatchQueue.main.async {
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
        cell.set(with: post, by: author(with: post.sourceId))
        return cell
    }
    
    private func author(with sourceID: Int) -> ProfileRepresenatable {
        let authorSource: [ProfileRepresenatable] = sourceID >= 0 ? self.profiles : self.groups
        let normalSourceId = abs(sourceID)
        return authorSource.first { $0.id == normalSourceId }!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let post = posts[indexPath.row]
        guard let text = post.text else { return 0 }
        let labelFont = UIFont.systemFont(ofSize: 17, weight: .regular)
        let postPhotoHeight = CGFloat(post.attachments?.first?.photo?.adjustedHeight ?? 0)
        return text.height(font: labelFont) + postPhotoHeight + 120
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        UIView()
    }
}
