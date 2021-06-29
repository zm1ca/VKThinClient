//
//  ProfileCell.swift
//  VKThinClient
//
//  Created by Źmicier Fiedčanka on 28.06.21.
//

import UIKit

class ProfileCell: UITableViewCell {
    
    static let reuseID = "ProfileCell"
    
    @IBOutlet weak var icon:      UIImageView!
    @IBOutlet weak var cathegory: UILabel!
    @IBOutlet weak var value:     UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
