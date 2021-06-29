//
//  UILabel+Ext.swift
//  VKThinClient
//
//  Created by Źmicier Fiedčanka on 29.06.21.
//

import UIKit

extension String {
    func height(font: UIFont) -> CGFloat {
        let width = UIScreen.main.bounds.size.width
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
    
        return ceil(boundingBox.height)
    }
}
