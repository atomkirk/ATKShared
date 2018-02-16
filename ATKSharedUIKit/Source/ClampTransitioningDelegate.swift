//
//  ClampTransitioningDelegate.swift
//  Spoken
//
//  Created by Adam Kirk on 5/11/15.
//  Copyright (c) 2015 Spoken. All rights reserved.
//

import UIKit

open class ClampTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {

    open func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ClampTransitioningAnimator(direction: .presenting)
    }

    open func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ClampTransitioningAnimator(direction: .dismissing)
    }

}
