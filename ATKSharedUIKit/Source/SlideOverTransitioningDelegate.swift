//
//  SlideTransitioningDelegate.swift
//  Concierge
//
//  Created by Adam Kirk on 5/7/15.
//  Copyright (c) 2015 Mysterious Trousers. All rights reserved.
//

import UIKit

public class SlideOverTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {

    public func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SlideOverTransitioningAnimator(direction: .Presenting)
    }

    public func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SlideOverTransitioningAnimator(direction: .Dismissing)
    }
    
}
