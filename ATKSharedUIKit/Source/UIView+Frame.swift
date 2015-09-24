//
//  File.swift
//  Spoken
//
//  Created by Adam Kirk on 6/22/15.
//  Copyright (c) 2015 Spoken. All rights reserved.
//

import UIKit

public extension UIView {

    public var x: CGFloat {
        get {
            return self.frame.origin.x
        }
        set {
            var r = self.frame
            r.origin.x = newValue
            self.frame = r
        }
    }

    public var y: CGFloat {
        get {
            return self.frame.origin.y
        }
        set {
            var r = self.frame
            r.origin.y = newValue
            self.frame = r
        }
    }

    public var width: CGFloat {
        get {
            return self.frame.size.width
        }
        set {
            var r = self.frame
            r.size.width = newValue
            self.frame = r
        }
    }

    public var height: CGFloat {
        get {
            return self.frame.size.height
        }
        set {
            var r = self.frame
            r.size.height = newValue
            self.frame = r
        }
    }

}