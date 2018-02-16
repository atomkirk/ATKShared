//
//  SlideTransitioningDelegate.swift
//  Concierge
//
//  Created by Adam Kirk on 5/7/15.
//  Copyright (c) 2015 Mysterious Trousers. All rights reserved.
//

import UIKit

open class SlideOverTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {

    open func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SlideOverTransitioningAnimator(direction: .presenting)
    }

    open func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SlideOverTransitioningAnimator(direction: .dismissing)
    }
    
}
