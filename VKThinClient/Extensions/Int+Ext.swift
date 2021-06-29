//
//  Int+Ext.swift
//  VKThinClient
//
//  Created by Źmicier Fiedčanka on 29.06.21.
//

import Foundation

extension Int {
    var shortRepresentation: String {
        if self < 1000 {
            return "\(self)"
        } else if self < 1000000 {
            return String(format: "%.1f", Double(self) / 1000.0) + "K"
        } else {
            return String(format: "%.1f", Double(self) / 1000000.0) + "M"
        }
    }
}
