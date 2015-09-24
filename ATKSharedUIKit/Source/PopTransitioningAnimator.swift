//
//  PopTransitioningAnimator.swift
//  Spoken
//
//  Created by Adam Kirk on 5/29/15.
//  Copyright (c) 2015 Spoken. All rights reserved.
//

import UIKit

public class PopTransitioningAnimator: BaseTransitioningAnimator, UIViewControllerAnimatedTransitioning {

    public func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        if self.direction == .Presenting {
            return 1
        }
        else {
            return 0.33
        }
    }

    public func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        switch self.direction {
        case .Presenting:
            let fromController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
            let toController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
            transitionContext.containerView()!.addSubview(toController.view)

            toController.view.alpha = 0
            toController.view.transform = CGAffineTransformMakeScale(0.5, 0.5)
            fromController.view.transform = CGAffineTransformIdentity
            UIView.animateWithDuration(self.transitionDuration(transitionContext), delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 10, options: [], animations: { () -> Void in
                toController.view.alpha = 1
                toController.view.transform = CGAffineTransformIdentity
                fromController.view.transform = CGAffineTransformMakeScale(0.9, 0.9)
                }, completion: { (finished: Bool) -> Void in
                    transitionContext.completeTransition(true)
            })
        case .Dismissing:
            let fromController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
            let toController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
            transitionContext.containerView()!.addSubview(fromController.view)

            fromController.view.alpha = 1
            fromController.view.transform = CGAffineTransformIdentity
            toController.view.transform = CGAffineTransformMakeScale(0.9, 0.9)
            UIView.animateWithDuration(self.transitionDuration(transitionContext), animations: { () -> Void in
                fromController.view.alpha = 0
                fromController.view.transform = CGAffineTransformMakeScale(0.8, 0.8)
                toController.view.transform = CGAffineTransformIdentity
                }, completion: { (finished: Bool) -> Void in
                    transitionContext.completeTransition(true)
            })
        }
    }
    
}
