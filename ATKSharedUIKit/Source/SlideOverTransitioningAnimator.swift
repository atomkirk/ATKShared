//
//  SlideTransitioningAnimator.swift
//  Concierge
//
//  Created by Adam Kirk on 5/7/15.
//  Copyright (c) 2015 Mysterious Trousers. All rights reserved.
//

import UIKit

open class SlideOverTransitioningAnimator: BaseTransitioningAnimator, UIViewControllerAnimatedTransitioning {

    open func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.33
    }

    open func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        switch self.direction {
        case .presenting:
            let fromController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
            let toController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
            transitionContext.containerView.addSubview(toController.view)

            let fromStartRect = fromController.view.frame

            let toStartRect = CGRect(x: fromStartRect.origin.x + fromStartRect.size.width, y: fromStartRect.origin.y, width: fromStartRect.size.width, height: fromStartRect.size.height)
            let toEndRect = fromStartRect

            toController.view.frame = toStartRect
            UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: { () -> Void in
                toController.view.frame = toEndRect
            }, completion: { (finished: Bool) -> Void in
                transitionContext.completeTransition(true)
            })
        case .dismissing:
            let fromController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
            let toController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
            transitionContext.containerView.addSubview(toController.view)

            let fromStartRect = fromController.view.frame
            let fromEndRect = CGRect(x: fromStartRect.origin.x + fromStartRect.size.width, y: fromStartRect.origin.y, width: fromStartRect.size.width, height: fromStartRect.size.height)

            let toStartRect = CGRect(x: fromStartRect.origin.x - fromStartRect.size.width, y: fromStartRect.origin.y, width: fromStartRect.size.width, height: fromStartRect.size.height)
            let toEndRect = fromStartRect

            fromController.view.frame = fromStartRect
            toController.view.frame = toStartRect
            UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: { () -> Void in
                fromController.view.frame = fromEndRect
                toController.view.frame = toEndRect
            }, completion: { (finished: Bool) -> Void in
                transitionContext.completeTransition(true)
            })
        }
    }

}
