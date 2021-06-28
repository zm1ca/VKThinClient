//
//  HeaderView.swift
//  VKThinClient
//
//  Created by Źmicier Fiedčanka on 28.06.21.
//

import UIKit

class HeaderView: UIView {
    
    @IBOutlet weak var profilePhoto: UIImageView!
    @IBOutlet weak var name:         UILabel!
    @IBOutlet weak var bio:          UILabel!
    @IBOutlet weak var status:       UILabel!
    

    static func instantiate() -> HeaderView {
        let view: HeaderView = initFromNib()
        return view
    }
}

extension UIView {
    class func initFromNib<T: UIView>() -> T {
        Bundle.main.loadNibNamed(String(describing: self), owner: nil, options: nil)?[0] as! T
    }
}
