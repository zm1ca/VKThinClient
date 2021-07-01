//
//  ProfileVC.swift
//  VKThinClient
//
//  Created by Źmicier Fiedčanka on 28.06.21.
//

import UIKit

class ProfileVC: UIViewController {
    
    let dataFetcher = DataFetcher()
    private var requestsYetToMake = 4 //magic number :(

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
    
    @IBOutlet weak var signOutButton: UIButton!
    
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.subviews.forEach { $0.alpha = 0 }
        contentView.isUserInteractionEnabled = false
        configireUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.visibleViewController?.title = "Profile"
    }
    
    
    //MARK: Configuration
    private func configireUI() {
        view.bringSubviewToFront(activityIndicator)
        contentView.layer.cornerRadius   = 10
        signOutButton.layer.cornerRadius = 16
        signOutButton.layer.borderWidth  = 1
        signOutButton.backgroundColor    = #colorLiteral(red: 0.9841352105, green: 0.9841352105, blue: 0.9841352105, alpha: 1)
        signOutButton.layer.borderColor  = UIColor.gray.cgColor
        setAvatar()
        setProfileInfo()
    }
    
    
    //MARK: Populating view with fetched daata
    private func setAvatar() {
        dataFetcher.getUserAvatar { result in
            guard let result = result, let avatarURL = result.photo400Orig else { return }
            ImageLoader.shared.downloadImage(from: avatarURL) { image in
                guard let image = image else { return }
                DispatchQueue.main.async { [self] in
                    self.avatarImageView.image = image
                    presentUIIfEveryElementDidLoad()
                }
            }
        }
    }
    
    private func setProfileInfo() {
        dataFetcher.getProfileInfo { profileResponse in
            guard let profileResponse = profileResponse else { return } //alert
            DispatchQueue.main.async { [self] in
                self.nameLabel.text = profileResponse.name
                self.idLabel.text   = "id\(profileResponse.id)"
                detailsBlock1.set(title: "Sex",      value: sex(by: profileResponse.sex))
                detailsBlock2.set(title: "Relation", value: relation(by: profileResponse.relation))
                detailsBlock3.set(title: "Birthday", value: profileResponse.bdate)
                detailsBlock4.set(title: "City",     value: city(from: profileResponse.homeTown))
                presentUIIfEveryElementDidLoad()
            }
        }
        
        dataFetcher.getFriendsCount { friendsCount in
            guard let friendsCount = friendsCount else { return }
            DispatchQueue.main.async { [self] in
                detailsBlock5.set(title: "Friends", value: "\(friendsCount)")
                presentUIIfEveryElementDidLoad()
            }
        }
        
        dataFetcher.getSubscriptionsCount { subscriptionsCount in
            guard let subscriptionsCount = subscriptionsCount else { return }
            DispatchQueue.main.async { [self] in
                detailsBlock6.set(title: "Groups", value: "\(subscriptionsCount)")
                presentUIIfEveryElementDidLoad()
            }
        }
    }
    
    private func presentUIIfEveryElementDidLoad() {
        guard requestsYetToMake - 1 == 0 else {requestsYetToMake -= 1; return }
        UIView.animate(withDuration: 1) {
            self.contentView.subviews.forEach { $0.alpha = 1.0 }
        }
        contentView.isUserInteractionEnabled = true
        self.activityIndicator.stopAnimating()
    }
    
    //MARK: Handling actions
    @IBAction func contentViewTapped(_ sender: Any) {
        let fliptype: UIView.AnimationOptions = avatarImageView.isHidden ? .transitionFlipFromRight : .transitionFlipFromLeft
        UIView.transition(with: contentView, duration: 0.75, options: [fliptype]) { [weak self] in
            guard let self = self else { return }
            self.contentView.subviews.forEach { $0.isHidden.toggle() }
        }
    }
    
    @IBAction func signoutButtonTapped(_ sender: Any) {
        SceneDelegate.shared().authService.vkLogout()
    }
}
