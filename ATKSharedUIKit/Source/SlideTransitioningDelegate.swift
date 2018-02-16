//
//  SlideTransitioningDelegate.swift
//  Spoken
//
//  Created by Adam Kirk on 5/7/15.
//  Copyright (c) 2015 Spoken. All rights reserved.
//

import UIKit

open class SlideTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {

    open func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SlideTransitioningAnimator(direction: .presenting)
    }

    open func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SlideTransitioningAnimator(direction: .dismissing)
    }
}
