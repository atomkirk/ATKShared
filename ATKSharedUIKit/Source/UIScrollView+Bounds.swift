//
//  UIScrollView+Insets.swift
//  Spoken
//
//  Created by Adam Kirk on 6/22/15.
//  Copyright (c) 2015 Spoken. All rights reserved.
//

import UIKit

public extension UIScrollView {

    public var contentOffsetX: CGFloat {
        get {
            return self.contentOffset.x
        }
        set {
            var p = self.contentOffset
            p.x = newValue
            self.contentOffset = p
        }
    }

    public var contentOffsetY: CGFloat {
        get {
            return self.contentOffset.y
        }
        set {
            var p = self.contentOffset
            p.y = newValue
            self.contentOffset = p
        }
    }

    public var contentInsetTop: CGFloat {
        get {
            return self.contentInset.top
        }
        set {
            var p = self.contentInset
            p.top = newValue
            self.contentInset = p
        }
    }

    public var contentInsetBottom: CGFloat {
        get {
            return self.contentInset.bottom
        }
        set {
            var p = self.contentInset
            p.bottom = newValue
            self.contentInset = p
        }
    }

    public var contentInsetLeft: CGFloat {
        get {
            return self.contentInset.left
        }
        set {
            var p = self.contentInset
            p.left = newValue
            self.contentInset = p
        }
    }

    public var contentInsetRight: CGFloat {
        get {
            return self.contentInset.right
        }
        set {
            var p = self.contentInset
            p.right = newValue
            self.contentInset = p
        }
    }

}