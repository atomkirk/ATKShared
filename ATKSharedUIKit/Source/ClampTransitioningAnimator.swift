//
//  ClampTransitioningAnimator.swift
//  Spoken
//
//  Created by Adam Kirk on 5/11/15.
//  Copyright (c) 2015 Spoken. All rights reserved.
//

import UIKit

class ClampTransitioningAnimator: BaseTransitioningAnimator, UIViewControllerAnimatedTransitioning {

    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.33
    }

    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        switch self.direction {
        case .Presenting:
            let toController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as! UINavigationController
            transitionContext.containerView()!.addSubview(toController.view)

            var navigationBarStartRect = toController.navigationBar.frame
            let navigationBarEndRect = navigationBarStartRect
            navigationBarStartRect.origin.y -= CGRectGetHeight(navigationBarStartRect) + 20

            var viewControllerStartRect = toController.visibleViewController!.view.frame
            let viewControllerEndRect = viewControllerStartRect
            viewControllerStartRect.origin.y += CGRectGetHeight(viewControllerStartRect)

            toController.navigationBar.frame = navigationBarStartRect
            toController.visibleViewController!.view.frame = viewControllerStartRect
            UIView.animateWithDuration(self.transitionDuration(transitionContext), animations: { () -> Void in
                toController.navigationBar.frame = navigationBarEndRect
                toController.visibleViewController!.view.frame = viewControllerEndRect
            }, completion: { (finished: Bool) -> Void in
                transitionContext.completeTransition(true)
            })
        case .Dismissing:
            let fromController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! UINavigationController
            transitionContext.containerView()!.addSubview(fromController.view)

            let navBarStartRect = fromController.navigationBar.frame
            var navBarEndRect = navBarStartRect
            navBarEndRect.origin.y -= CGRectGetHeight(navBarStartRect) + 20

            let controllerStartRect = fromController.visibleViewController!.view.frame
            var controllerEndRect = controllerStartRect
            controllerEndRect.origin.y += CGRectGetHeight(controllerStartRect)

            fromController.navigationBar.frame = navBarStartRect
            fromController.visibleViewController!.view.frame = controllerStartRect
            UIView.animateWithDuration(self.transitionDuration(transitionContext), animations: { () -> Void in
                fromController.navigationBar.frame = navBarEndRect
                fromController.visibleViewController!.view.frame = controllerEndRect
            }, completion: { (finished: Bool) -> Void in
                transitionContext.completeTransition(true)
            })
        }
    }
    
}
