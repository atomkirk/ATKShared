//
//  PopTransitioningDelegate.swift
//  Spoken
//
//  Created by Adam Kirk on 5/29/15.
//  Copyright (c) 2015 Spoken. All rights reserved.
//

import UIKit

open class PopTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {

    open func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PopTransitioningAnimator(direction: .presenting)
    }

    open func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PopTransitioningAnimator(direction: .dismissing)
    }
}
