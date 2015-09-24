//
//  SmartError.swift
//  Spoken
//
//  Created by Adam Kirk on 6/6/15.
//  Copyright (c) 2015 Spoken. All rights reserved.
//

import Foundation

public typealias PassInErrorBlock = (error: NSError) -> Void

public class PassInError: NSObject {

    public dynamic var ref: NSError?

    public let block: PassInErrorBlock?

    public init(block: PassInErrorBlock? = nil) {
        self.block = block
        super.init()
        self.addObserver(self, forKeyPath: "ref", options: [], context: nil)
    }

    deinit {
        self.removeObserver(self, forKeyPath: "ref")
    }


    // MARK: - KVO

    public override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if object is PassInError {
            if keyPath == "ref" {
                if let error = self.ref {
                    if let block = self.block {
                        block(error: error)
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
