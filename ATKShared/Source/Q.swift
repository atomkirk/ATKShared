//
//  Q.swift
//  Spoken
//
//  Created by Adam Kirk on 6/6/15.
//  Copyright (c) 2015 Spoken. All rights reserved.
//

import Foundation

public typealias QBlock = () -> Void

private func serialQueueWithName(name: String) -> NSOperationQueue {
    let queue = NSOperationQueue()
    queue.name = "com.spoken.upload-queue"
    queue.maxConcurrentOperationCount = 1
    return queue
}

public class Q: NSObject {

    private static let filesQueue = serialQueueWithName("com.spoken.files-queue")

    private static let uploaderQueue = serialQueueWithName("com.spoken.uploader-queue")

    private static let photosQueue = serialQueueWithName("com.spoken.photos-queue")

    public class func main(block: QBlock) {
        NSOperationQueue.mainQueue().addOperationWithBlock(block)
    }

    public class func files(block: QBlock) {
        filesQueue.addOperationWithBlock(block)
    }

    public class func uploader(block: QBlock) {
        uploaderQueue.addOperationWithBlock(block)
    }

    public class func photos(block: QBlock) {
        photosQueue.addOperationWithBlock(block)
    }


    // MARK: - standard queues

    public class func def(block: QBlock) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block);
    }

    public class func background(block: QBlock) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), block);
    }

    public class func high(block: QBlock) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), block);
    }

    public class func low(block: QBlock) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), block);
    }

    public class func delay(seconds: NSTimeInterval, block: QBlock) {
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(seconds * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue(), block)
    }

}
