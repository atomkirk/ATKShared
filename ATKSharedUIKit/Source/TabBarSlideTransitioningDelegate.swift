//
//  TabBarSlideTransitioningDelegate.swift
//  Spoken
//
//  Created by Adam Kirk on 5/15/15.
//  Copyright (c) 2015 Spoken. All rights reserved.
//

import UIKit

class TabBarSlideTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {

    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return TabBarSlideTransitioningAnimator(direction: .Presenting)
    }

    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return TabBarSlideTransitioningAnimator(direction: .Dismissing)
    }
    
}
