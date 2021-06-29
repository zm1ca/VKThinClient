//
//  FeedCell.swift
//  VKThinClient
//
//  Created by Źmicier Fiedčanka on 29.06.21.
//

import UIKit

protocol VKFeedCell {
    func set(with post: Post)
}

class FeedCell: UITableViewCell, VKFeedCell {
    
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var sourceNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var postTextLabel: UILabel!
    @IBOutlet weak var likesCountLabel: UILabel!
    @IBOutlet weak var commentsCountLabel: UILabel!
    @IBOutlet weak var sharesCountLabel: UILabel!
    @IBOutlet weak var viewsCountLabel: UILabel!
    
    let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.locale = Locale(identifier: "ru_RU")
        df.dateFormat = "d MMM 'в' HH:mm"
        return df
    }()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    private func configure() {
        backgroundColor = .clear
        container.layer.cornerRadius = 10
        container.backgroundColor = .white
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func set(with post: Post) {
        postTextLabel.text      = post.text
        likesCountLabel.text    = "\((post.likes?.count ?? 0).shortRepresentation)"
        commentsCountLabel.text = "\((post.comments?.count ?? 0).shortRepresentation)"
        sharesCountLabel.text   = "\((post.reposts?.count ?? 0).shortRepresentation)"
        viewsCountLabel.text    = "\((post.views?.count ?? 0).shortRepresentation)"
        dateLabel.text          = dateFormatter.string(from: Date(timeIntervalSince1970: post.date))
    }
    
}
