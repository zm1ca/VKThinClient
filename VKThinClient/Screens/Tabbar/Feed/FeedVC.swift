//
//  FeedVC.swift
//  VKThinClient
//
//  Created by Źmicier Fiedčanka on 28.06.21.
//

import UIKit
import Moya

class FeedVC: UITableViewController {
    
    var posts    = [Post]()
    var groups   = [Group]()
    var profiles = [Profile]()
    
    var feedOffset: String?
    var isLoadingMoreFollowers = false
    
    let dataFetcher = DataFetchingService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = #colorLiteral(red: 0.9567961097, green: 0.9567961097, blue: 0.9567961097, alpha: 1)
        configureRefreshControl()
    }
    
    private func configureRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        refreshControl.tintColor = .black
        self.refreshControl = refreshControl
    }
    
    @objc private func handleRefresh() {
        loadPostsAndUpdateUI()
        self.refreshControl?.endRefreshing()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.visibleViewController?.title = "Feed"
        loadPostsAndUpdateUI()
    }
    
    private func loadPostsAndUpdateUI() {
        dataFetcher.getPosts(startingFrom: feedOffset) { feedResponse in
            guard let feed = feedResponse else {
                self.presentAlertOnMainThread(withTitle: "Networking Error", andMessage: "Unable to load feed.\nPlease check your internet connection")
                return
            }
            
            self.feedOffset = feed.nextFrom
            self.posts.append(contentsOf: feed.items)
            self.groups.append(contentsOf: feed.groups)
            self.profiles.append(contentsOf: feed.profiles)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension FeedVC {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count - 1 //TODO: catch bug
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let post = posts[indexPath.row]
        guard let text = post.text else { return 0 }
        let labelFont = UIFont.systemFont(ofSize: 17, weight: .regular)
        let postPhotoHeight = CGFloat(post.attachments?.first?.photo?.adjustedHeight ?? 0)
        return text.height(font: labelFont) + postPhotoHeight + 125
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        UIView()
    }
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY         = scrollView.contentOffset.y
        let contentHeight   = scrollView.contentSize.height
        let screenHeight    = scrollView.frame.size.height
        
        if offsetY > contentHeight - screenHeight {
            guard !isLoadingMoreFollowers else { return }
            loadPostsAndUpdateUI()
        }
    }
}
