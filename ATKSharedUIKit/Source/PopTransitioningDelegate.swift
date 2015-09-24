//
//  PopTransitioningDelegate.swift
//  Spoken
//
//  Created by Adam Kirk on 5/29/15.
//  Copyright (c) 2015 Spoken. All rights reserved.
//

import UIKit

class PopTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {

    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PopTransitioningAnimator(direction: .Presenting)
    }

    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PopTransitioningAnimator(direction: .Dismissing)
    }
}
