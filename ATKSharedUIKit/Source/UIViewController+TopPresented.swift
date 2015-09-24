//
//  UIViewController+TopPresented.swift
//  Spoken
//
//  Created by Adam Kirk on 5/29/15.
//  Copyright (c) 2015 Spoken. All rights reserved.
//

import UIKit

public extension UIViewController {

    public func topPresentedViewController() -> UIViewController {
        if var next = self.presentedViewController {
            while let n = next.presentedViewController {
                next = n
            }
            return next
        }
        else {
            return self
        }
    }

}