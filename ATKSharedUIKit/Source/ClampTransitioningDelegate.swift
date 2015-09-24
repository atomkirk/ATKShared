//
//  ClampTransitioningDelegate.swift
//  Spoken
//
//  Created by Adam Kirk on 5/11/15.
//  Copyright (c) 2015 Spoken. All rights reserved.
//

import UIKit

class ClampTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {

    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ClampTransitioningAnimator(direction: .Presenting)
    }

    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ClampTransitioningAnimator(direction: .Dismissing)
    }

}
