//
//  SlideTransitioningDelegate.swift
//  Spoken
//
//  Created by Adam Kirk on 5/7/15.
//  Copyright (c) 2015 Spoken. All rights reserved.
//

import UIKit

public class SlideTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {

    public func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SlideTransitioningAnimator(direction: .Presenting)
    }

    public func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SlideTransitioningAnimator(direction: .Dismissing)
    }
}
