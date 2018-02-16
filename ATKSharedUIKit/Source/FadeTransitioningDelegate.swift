//
//  FadeTransitioningDelegate.swift
//  Spoken
//
//  Created by Adam Kirk on 7/11/15.
//  Copyright (c) 2015 Spoken. All rights reserved.
//

import UIKit

open class FadeTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {

    open func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return FadeTransitioningAnimator(direction: .presenting)
    }

    open func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return FadeTransitioningAnimator(direction: .dismissing)
    }
}
