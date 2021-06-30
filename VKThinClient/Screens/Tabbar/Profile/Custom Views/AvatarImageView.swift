//
//  AvatarImageView.swift
//  VKThinClient
//
//  Created by Źmicier Fiedčanka on 30.06.21.
//

import UIKit

class AvatarImageView: UIImageView {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        contentMode = .scaleAspectFill
        layer.masksToBounds = false
        layer.cornerRadius = frame.width / 2
        clipsToBounds      = true
        layer.borderColor  = UIColor.gray.cgColor
        layer.borderWidth  = 3
        image = UIImage(systemName: "person.fill")
    }
}
