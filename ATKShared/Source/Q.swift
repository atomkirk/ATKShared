//
//  Q.swift
//  Spoken
//
//  Created by Adam Kirk on 6/6/15.
//  Copyright (c) 2015 Spoken. All rights reserved.
//

import Foundation

public typealias QBlock = () -> Void

private func serialQueueWithName(_ name: String) -> OperationQueue {
    let queue = OperationQueue()
    queue.name = "com.spoken.upload-queue"
    queue.maxConcurrentOperationCount = 1
    return queue
}

open class Q: NSObject {

    fileprivate static let filesQueue = serialQueueWithName("com.spoken.files-queue")

    fileprivate static let uploaderQueue = serialQueueWithName("com.spoken.uploader-queue")

    fileprivate static let photosQueue = serialQueueWithName("com.spoken.photos-queue")

    open class func main(_ block: @escaping QBlock) {
        OperationQueue.main.addOperation(block)
    }

    open class func files(_ block: @escaping QBlock) {
        filesQueue.addOperation(block)
    }

    open class func uploader(_ block: @escaping QBlock) {
        uploaderQueue.addOperation(block)
    }

    open class func photos(_ block: @escaping QBlock) {
        photosQueue.addOperation(block)
    }


    // MARK: - standard queues

    open class func def(_ block: @escaping QBlock) {
        DispatchQueue.global(qos: .default).async(execute: block);
    }

    open class func background(_ block: @escaping QBlock) {
        DispatchQueue.global(qos: .background).async(execute: block);
    }

    open class func high(_ block: @escaping QBlock) {
        DispatchQueue.global(qos: .userInteractive).async(execute: block);
    }

    open class func low(_ block: @escaping QBlock) {
        DispatchQueue.global(qos: .unspecified).async(execute: block);
    }

    open class func delay(_ seconds: TimeInterval, block: @escaping QBlock) {
        let delayTime = DispatchTime.now() + Double(Int64(seconds * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: delayTime, execute: block)
    }

}
