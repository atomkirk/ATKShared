//
//  ImageCache.swift
//  Spoken
//
//  Created by Adam Kirk on 7/3/15.
//  Copyright (c) 2015 Spoken. All rights reserved.
//

import UIKit

public typealias ImageCacheCompletionBlock = (url: NSURL, cached: Bool, image: UIImage) -> Void

public class ImageCache {

    public static let shared = ImageCache()

    private var loadingBlocks = [String: [ImageCacheCompletionBlock]]()

    private let cache = NSCache()

    /**
        Don't initialize your own. Use `shared`
    */
    private init() { }
    
    public func hasImage(url: NSURL) -> Bool {
        let key = keyForURL(url)
        return cache.objectForKey(key) != nil
    }
    
    public func cacheImage(image: UIImage, url: NSURL) {
        let key = keyForURL(url)
        self.cache.setObject(image, forKey: key)
    }
    
    public func preloadImageAtURL(url: NSURL) {
        loadImageAtURL(url) { url, cached, image in }
    }

    public func loadImageAtURL(url: NSURL, completion: ImageCacheCompletionBlock) {
        let key = keyForURL(url)
        if let image = cache.objectForKey(key) as? UIImage {
            completion(url: url, cached: true, image: image)
        }
        else {
            if var blocks = loadingBlocks[key] {
                blocks.append(completion)
            }
            else {
                loadingBlocks[key] = [completion]
                let task = NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: { (data, response, error) in
                    Q.main {
                        if let
                            HTTPResponse = response as? NSHTTPURLResponse,
                            data = data
                            where HTTPResponse.statusCode == 200 {
                                if let image = UIImage(data: data), let blocks = self.loadingBlocks[key] {
                                    self.cache.setObject(image, forKey: key)
                                    for block in blocks {
                                        block(url: url, cached: false, image: image)
                                    }
                                    self.loadingBlocks.removeValueForKey(key)
                                }
                                else {
                                    print("failed to convert data to image.")
                                }
                        }
                    }
                })
                task.resume()
            }
        }
    }

    private func keyForURL(url: NSURL) -> String {
        let data = url.absoluteString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!
        return data.base64EncodedStringWithOptions([])
    }
    
}