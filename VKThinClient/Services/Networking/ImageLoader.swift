//
//  ImageLoader.swift
//  VKThinClient
//
//  Created by Źmicier Fiedčanka on 29.06.21.
//

import UIKit

class ImageLoader  {
    
    static let shared = ImageLoader()
    
    private init() { }
    
    func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void) {
        //lookup in cache
        
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard self != nil,
                error == nil,
                let response = response as? HTTPURLResponse, response.statusCode == 200,
                let data = data,
                let image = UIImage(data: data) else {
                    completed(nil)
                    return
                }

            //save to cache
            completed(image)
        }
        
        task.resume()
    }
}
