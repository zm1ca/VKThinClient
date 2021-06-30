//
//  ProfileVC.swift
//  VKThinClient
//
//  Created by Źmicier Fiedčanka on 28.06.21.
//

import UIKit

class ProfileVC: UIViewController {
    
    ///FIX: massive code duplication
    
    let dataFetcher = DataFetchingService()
    
    private var requestsYetToMake = 4

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
        contentView.isUserInteractionEnabled = false
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
    }
    
    //MARK: Configuration
    private func setAvatar() {
        dataFetcher.getUserAvatar { result in
            guard let result = result, let avatarURL = result.photo100 else { return }
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
        
        dataFetcher.getFriendsCount { subscriptionsCount in
            guard let subscriptionsCount = subscriptionsCount else { return }
            DispatchQueue.main.async { [self] in
                detailsBlock6.set(title: "Subscriptions", value: "\(subscriptionsCount)")
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
    
    //MARK: Handle tap
    @IBAction func contentViewTapped(_ sender: Any) {
        let fliptype: UIView.AnimationOptions = avatarImageView.isHidden ? .transitionFlipFromRight : .transitionFlipFromLeft
        UIView.transition(with: contentView, duration: 0.75, options: [fliptype]) { [weak self] in
            guard let self = self else { return }
            self.contentView.subviews.forEach { $0.isHidden.toggle() }
        }
    }
}

extension ProfileVC {
    //Would be better to add DetailType call that in and switch. Consider MVVM
    private func sex(by id: Int) -> String {
        switch id {
        case 0: return  "Not set"
        case 1: return  "Female"
        case 2: return  "Male"
        default: return "Other"
        }
    }
    
    private func relation(by id: Int) -> String {
        switch id {
        case 0: return "Not Set"
        case 1: return "Single"
        case 2: return "Relationship"
        case 3: return "Engaged"
        case 4: return "Married"
        case 5: return "Complicated"
        case 6: return "Searchijg"
        case 7: return "In Love"
        case 8: return "Civil"
        default: return "Other"
        }
    }
    
    private func city(from fetchedCity: String) -> String {
        guard !fetchedCity.isEmpty else { return "Not Set" }
        return fetchedCity
    }
}
