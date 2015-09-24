//
//  FadeTransitioningDelegate.swift
//  Spoken
//
//  Created by Adam Kirk on 7/11/15.
//  Copyright (c) 2015 Spoken. All rights reserved.
//

import UIKit

public class FadeTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {

    public func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return FadeTransitioningAnimator(direction: .Presenting)
    }

    public func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return FadeTransitioningAnimator(direction: .Dismissing)
    }
}