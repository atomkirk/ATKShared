//
//  ImageCache.swift
//  Spoken
//
//  Created by Adam Kirk on 7/3/15.
//  Copyright (c) 2015 Spoken. All rights reserved.
//

import UIKit

public typealias ImageCacheCompletionBlock = (_ url: URL, _ cached: Bool, _ image: UIImage) -> Void

open class ImageCache {

    open static let shared = ImageCache()

    fileprivate var loadingBlocks = [String: [ImageCacheCompletionBlock]]()

    fileprivate let cache = NSCache<NSString, UIImage>()

    /**
        Don't initialize your own. Use `shared`
    */
    fileprivate init() { }
    
    open func hasImage(_ url: URL) -> Bool {
        let key = keyForURL(url)
        return cache.object(forKey: key) != nil
    }
    
    open func cacheImage(_ image: UIImage, url: URL) {
        let key = keyForURL(url)
        self.cache.setObject(image, forKey: key)
    }
    
    open func preloadImageAtURL(_ url: URL) {
        loadImageAtURL(url) { url, cached, image in }
    }
    
    open func clear() {
        cache.removeAllObjects()
    }

    open func loadImageAtURL(_ url: URL, completion: @escaping ImageCacheCompletionBlock) {
        let key = keyForURL(url)
        if let image = cache.object(forKey: key) {
            completion(url, true, image)
        }
        else {
            if var blocks = loadingBlocks[key as String] {
                blocks.append(completion)
            }
            else {
                loadingBlocks[key as String] = [completion]
                let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                    Q.main {
                        if let
                            HTTPResponse = response as? HTTPURLResponse,
                            let data = data
                            , HTTPResponse.statusCode == 200 {
                            if let image = UIImage(data: data), let blocks = self.loadingBlocks[key as String] {
                                    self.cache.setObject(image, forKey: key)
                                    for block in blocks {
                                        block(url, false, image)
                                    }
                                self.loadingBlocks.removeValue(forKey: key as String)
                                }
                                else {
                                    print("failed to convert data to image.")
                                }
                        }
                        else {
                            print("error: \(String(describing: error) )")
                        }
                    }
                })
                task.resume()
            }
        }
    }

    fileprivate func keyForURL(_ url: URL) -> NSString {
        let data = url.absoluteString.data(using: String.Encoding.utf8, allowLossyConversion: false)!
        return data.base64EncodedString(options: []) as NSString
    }
    
}
