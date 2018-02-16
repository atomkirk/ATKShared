//
//  TabBarSlideTransitioningDelegate.swift
//  Spoken
//
//  Created by Adam Kirk on 5/15/15.
//  Copyright (c) 2015 Spoken. All rights reserved.
//

import UIKit

open class TabBarSlideTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {

    open func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return TabBarSlideTransitioningAnimator(direction: .presenting)
    }

    open func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return TabBarSlideTransitioningAnimator(direction: .dismissing)
    }
    
}
