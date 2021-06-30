//
//  ImageLoader.swift
//  VKThinClient
//
//  Created by Źmicier Fiedčanka on 29.06.21.
//

import UIKit
import RealmSwift

class ImageLoader  {
    
    static let shared = ImageLoader()
      
    let realm = try! Realm()
    lazy var cache: [String: UIImage] = {
        var cache = [String: UIImage]()
        if let loadedCache = realm.objects(Cache.self).first?.cache {
            loadedCache.forEach { cache[$0.id] = UIImage(data: Data($0.imageData)) }
        }
        return cache
    }()
    
    private init() { }
    
    func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void) {
        if let image = cache[urlString] {
            completed(image)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self,
                  error == nil,
                  let response = response as? HTTPURLResponse, response.statusCode == 200,
                  let data = data,
                  let image = UIImage(data: data) else {
                completed(nil)
                return
            }
            self.cache[urlString] = image
            completed(image)
        }; task.resume()
    }
    
    func saveCache() {
        let updatedCache = List<CacheElement>()
        for (id, image) in cache {
            guard let data = UIImage.jpegData(image)(compressionQuality: 1) else { continue }
            updatedCache.append(CacheElement(id: id, imageData: NSData(data: data)))
        }
        
        try! realm.write {
            realm.add(Cache(cache: updatedCache), update: .modified)
        }
    }
}
