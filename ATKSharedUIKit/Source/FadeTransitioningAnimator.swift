//
//  FadeTransitioningAnimator.swift
//  Spoken
//
//  Created by Adam Kirk on 7/11/15.
//  Copyright (c) 2015 Spoken. All rights reserved.
//

import UIKit

public class FadeTransitioningAnimator: BaseTransitioningAnimator, UIViewControllerAnimatedTransitioning {

    public func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.33
    }

    public func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        switch self.direction {
        case .Presenting:
            let toController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
            transitionContext.containerView()!.addSubview(toController.view)

            toController.view.alpha = 0
            UIView.animateWithDuration(self.transitionDuration(transitionContext), animations: { () -> Void in
                toController.view.alpha = 1
                }, completion: { (finished: Bool) -> Void in
                    transitionContext.completeTransition(true)
            })
        case .Dismissing:
            let fromController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
            let toController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
            transitionContext.containerView()!.addSubview(toController.view)

            fromController.view.alpha = 1
            UIView.animateWithDuration(self.transitionDuration(transitionContext), animations: { () -> Void in
                fromController.view.alpha = 0
                }, completion: { (finished: Bool) -> Void in
                    transitionContext.completeTransition(true)
            })
        }
    }
    
}
