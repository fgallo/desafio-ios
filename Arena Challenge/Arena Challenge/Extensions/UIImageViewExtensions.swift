//
//  UIImageViewExtensions.swift
//  Arena Challenge
//
//  Created by Fernando Gallo on 09/04/17.
//  Copyright © 2017 arena. All rights reserved.
//

import Foundation
import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    func imageFromURL(_ imageURL: URL) {
        
        // check for cache
        if let cachedImage = imageCache.object(forKey: imageURL.absoluteString as AnyObject) as? UIImage {
            self.image = cachedImage
            return
        }
        
        // download image
        URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
            if let error = error {
                print(error)
                return
            }
            
            DispatchQueue.main.async(execute: { () -> Void in
                if let data = data, let image = UIImage(data: data) {
                    imageCache.setObject(image, forKey: imageURL.absoluteString as AnyObject)
                    self.image = image
                }
            })
        }.resume()
    }
    
}
