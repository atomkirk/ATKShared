//
//  SlideTransitioningAnimator.swift
//  Concierge
//
//  Created by Adam Kirk on 5/7/15.
//  Copyright (c) 2015 Mysterious Trousers. All rights reserved.
//

import UIKit

public class SlideOverTransitioningAnimator: BaseTransitioningAnimator, UIViewControllerAnimatedTransitioning {

    public func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.33
    }

    public func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        switch self.direction {
        case .Presenting:
            let fromController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
            let toController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
            transitionContext.containerView()!.addSubview(toController.view)

            let fromStartRect = fromController.view.frame

            let toStartRect = CGRectMake(fromStartRect.origin.x + fromStartRect.size.width, fromStartRect.origin.y, fromStartRect.size.width, fromStartRect.size.height)
            let toEndRect = fromStartRect

            toController.view.frame = toStartRect
            UIView.animateWithDuration(self.transitionDuration(transitionContext), animations: { () -> Void in
                toController.view.frame = toEndRect
            }, completion: { (finished: Bool) -> Void in
                transitionContext.completeTransition(true)
            })
        case .Dismissing:
            let fromController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
            let toController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
            transitionContext.containerView()!.addSubview(toController.view)

            let fromStartRect = fromController.view.frame
            let fromEndRect = CGRectMake(fromStartRect.origin.x + fromStartRect.size.width, fromStartRect.origin.y, fromStartRect.size.width, fromStartRect.size.height)

            let toStartRect = CGRectMake(fromStartRect.origin.x - fromStartRect.size.width, fromStartRect.origin.y, fromStartRect.size.width, fromStartRect.size.height)
            let toEndRect = fromStartRect

            fromController.view.frame = fromStartRect
            toController.view.frame = toStartRect
            UIView.animateWithDuration(self.transitionDuration(transitionContext), animations: { () -> Void in
                fromController.view.frame = fromEndRect
                toController.view.frame = toEndRect
            }, completion: { (finished: Bool) -> Void in
                transitionContext.completeTransition(true)
            })
        }
    }

}
