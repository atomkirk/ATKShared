//
//  ClampTransitioningDelegate.swift
//  Spoken
//
//  Created by Adam Kirk on 5/11/15.
//  Copyright (c) 2015 Spoken. All rights reserved.
//

import UIKit

public class ClampTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {

    public func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ClampTransitioningAnimator(direction: .Presenting)
    }

    public func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ClampTransitioningAnimator(direction: .Dismissing)
    }

}
