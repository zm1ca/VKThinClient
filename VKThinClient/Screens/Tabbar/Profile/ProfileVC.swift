//
//  ProfileVC.swift
//  VKThinClient
//
//  Created by Źmicier Fiedčanka on 28.06.21.
//

import UIKit

class ProfileVC: UIViewController {
    
    let dataFetcher = DataFetchingService()

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var contentView:     UIView!
    @IBOutlet weak var avatarImageView: AvatarImageView!
    @IBOutlet weak var nameLabel:       UILabel!
    @IBOutlet weak var idLabel:         UILabel!
    
    @IBOutlet weak var detailsBlock1: ProfileDetailsView!
    @IBOutlet weak var detailsBlock2: ProfileDetailsView!
    @IBOutlet weak var detailsBlock3: ProfileDetailsView!
    @IBOutlet weak var detailsBlock4: ProfileDetailsView!
    @IBOutlet weak var detailsBlock5: ProfileDetailsView!
    @IBOutlet weak var detailsBlock6: ProfileDetailsView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.subviews.forEach { $0.alpha = 0 }
        configireUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.visibleViewController?.title = "Profile"
    }
    
    private func configireUI() {
        view.bringSubviewToFront(activityIndicator)
        contentView.layer.cornerRadius = 10
        setAvatar()
        setProfileInfo()
        setDetailBlocks()
    }
    
    private func setAvatar() {
        dataFetcher.getUserAvatar { result in
            guard let result = result, let avatarURL = result.photo100 else { return }
            ImageLoader.shared.downloadImage(from: avatarURL) { image in
                guard let image = image else { return }
                DispatchQueue.main.async { [self] in
                    self.avatarImageView.image = image
                    presentUIIfNeeded()
                }
            }
        }
    }
    
    private func setProfileInfo() {
        dataFetcher.getProfileInfo { userResponse in
            guard let userResponse = userResponse else { return }
            DispatchQueue.main.async { [self] in
                self.nameLabel.text = userResponse.name
                self.idLabel.text   = "#\(userResponse.id)"
                presentUIIfNeeded()
            }
        }
    }
    
    private func presentUIIfNeeded() {
        guard activityIndicator.isAnimating else { return }
        UIView.animate(withDuration: 1) {
            self.contentView.subviews.forEach { $0.alpha = 1.0 }
        }
        self.activityIndicator.stopAnimating()
    }
    
    private func setDetailBlocks() {
        detailsBlock1.set(title: "Friends", value: 13)
        detailsBlock2.set(title: "Music", value: 12)
        detailsBlock3.set(title: "Groups", value: 54)
        detailsBlock4.set(title: "Videos", value: 982)
        detailsBlock5.set(title: "Comments", value: 1)
        detailsBlock6.set(title: "Likes", value: 0)
    }
    
    @IBAction func contentViewTapped(_ sender: Any) {
        let view = contentView!
        if view.backgroundColor == .white {
            view.backgroundColor = .systemTeal
        } else {
            view.backgroundColor = .white
        }
        
        UIView.transition(with: contentView, duration: 0.75, options: [.transitionFlipFromLeft]) { [weak self] in
            guard let self = self else { return }
            self.contentView.subviews.forEach { $0.isHidden.toggle() }
        }
    }
}
