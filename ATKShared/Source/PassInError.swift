//
//  SmartError.swift
//  Spoken
//
//  Created by Adam Kirk on 6/6/15.
//  Copyright (c) 2015 Spoken. All rights reserved.
//

import Foundation

public typealias PassInErrorBlock = (_ error: NSError) -> Void

open class PassInError: NSObject {

    @objc open dynamic var ref: NSError?

    open let block: PassInErrorBlock?

    public init(block: PassInErrorBlock? = nil) {
        self.block = block
        super.init()
        self.addObserver(self, forKeyPath: "ref", options: [], context: nil)
    }

    deinit {
        self.removeObserver(self, forKeyPath: "ref")
    }


    // MARK: - KVO

    open override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if object is PassInError {
            if keyPath == "ref" {
                if let error = self.ref {
                    if let block = self.block {
                        block(error)
                    }
                    if let underlyingError = error.userInfo[NSUnderlyingErrorKey] as? NSError {
                        print("ERROR =================================\n" +
                                "\(underlyingError.localizedDescription)\n" +
                                "=======================================\n")
                    }
                }
            }
        }
    }

}
