//
//  ClampTransitioningAnimator.swift
//  Spoken
//
//  Created by Adam Kirk on 5/11/15.
//  Copyright (c) 2015 Spoken. All rights reserved.
//

import UIKit

open class ClampTransitioningAnimator: BaseTransitioningAnimator, UIViewControllerAnimatedTransitioning {

    open func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.33
    }

    open func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        switch self.direction {
        case .presenting:
            let toController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as! UINavigationController
            transitionContext.containerView.addSubview(toController.view)

            var navigationBarStartRect = toController.navigationBar.frame
            let navigationBarEndRect = navigationBarStartRect
            navigationBarStartRect.origin.y -= navigationBarStartRect.height + 20

            var viewControllerStartRect = toController.visibleViewController!.view.frame
            let viewControllerEndRect = viewControllerStartRect
            viewControllerStartRect.origin.y += viewControllerStartRect.height

            toController.navigationBar.frame = navigationBarStartRect
            toController.visibleViewController!.view.frame = viewControllerStartRect
            UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: { () -> Void in
                toController.navigationBar.frame = navigationBarEndRect
                toController.visibleViewController!.view.frame = viewControllerEndRect
            }, completion: { (finished: Bool) -> Void in
                transitionContext.completeTransition(true)
            })
        case .dismissing:
            let fromController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as! UINavigationController
            transitionContext.containerView.addSubview(fromController.view)

            let navBarStartRect = fromController.navigationBar.frame
            var navBarEndRect = navBarStartRect
            navBarEndRect.origin.y -= navBarStartRect.height + 20

            let controllerStartRect = fromController.visibleViewController!.view.frame
            var controllerEndRect = controllerStartRect
            controllerEndRect.origin.y += controllerStartRect.height

            fromController.navigationBar.frame = navBarStartRect
            fromController.visibleViewController!.view.frame = controllerStartRect
            UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: { () -> Void in
                fromController.navigationBar.frame = navBarEndRect
                fromController.visibleViewController!.view.frame = controllerEndRect
            }, completion: { (finished: Bool) -> Void in
                transitionContext.completeTransition(true)
            })
        }
    }
    
}
