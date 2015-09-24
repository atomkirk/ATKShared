//
//  ImageCache.swift
//  Spoken
//
//  Created by Adam Kirk on 7/3/15.
//  Copyright (c) 2015 Spoken. All rights reserved.
//

import UIKit

public typealias ImageCacheCompletionBlock = (image: UIImage?) -> Void

public class ImageCache {

    public static let shared = ImageCache()

    private var loadingBlocks = [String: [ImageCacheCompletionBlock]]()

    private let cache = NSCache()

    /**
        Don't initialize your own. Use `shared`
    */
    private init() { }

    public func loadImageAtURL(url: NSURL, completion: ImageCacheCompletionBlock) {
        if let data = url.absoluteString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
            let key = data.base64EncodedStringWithOptions([])
            if let image = cache.objectForKey(key) as? UIImage {
                completion(image: image)
            }
            else {
                if var blocks = loadingBlocks[key] {
                    Q.main {
                        blocks.append(completion)
                    }
                }
                else {
                    loadingBlocks[key] = [completion]
                    let task = NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: { (data, response, error) in
                        Q.main {
                            if let HTTPResponse = response as? NSHTTPURLResponse, let data = data {
                                if HTTPResponse.statusCode == 200 {
                                    if let image = UIImage(data: data), let blocks = self.loadingBlocks[key] {
                                        self.cache.setObject(image, forKey: key)
                                        for block in blocks {
                                            block(image: image)
                                        }
                                        self.loadingBlocks.removeValueForKey(key)
                                    }
                                }
                            }
                        }
                    })
                    task.resume()
                }
            }
        }
    }

}