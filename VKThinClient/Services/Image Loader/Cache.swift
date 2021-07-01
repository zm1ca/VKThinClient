//
//  File.swift
//  VKThinClient
//
//  Created by Źmicier Fiedčanka on 29.06.21.
//

import UIKit
import RealmSwift

class Cache: Object {
    var cache = List<CacheElement>()
    @objc dynamic var id: Int = 0
    
    convenience init(cache: List<CacheElement>) {
        self.init()
        self.cache = cache
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
}

class CacheElement: Object  {
    @objc dynamic var id:        String = ""
    @objc dynamic var imageData: NSData = NSData()
    
    convenience init(id: String, imageData: NSData) {
        self.init()
        self.id = id
        self.imageData = imageData
    }
}
