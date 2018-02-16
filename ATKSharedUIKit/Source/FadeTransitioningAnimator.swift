//
//  FadeTransitioningAnimator.swift
//  Spoken
//
//  Created by Adam Kirk on 7/11/15.
//  Copyright (c) 2015 Spoken. All rights reserved.
//

import UIKit

open class FadeTransitioningAnimator: BaseTransitioningAnimator, UIViewControllerAnimatedTransitioning {

    open func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.33
    }

    open func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        switch self.direction {
        case .presenting:
            let toController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
            transitionContext.containerView.addSubview(toController.view)

            toController.view.alpha = 0
            UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: { () -> Void in
                toController.view.alpha = 1
                }, completion: { (finished: Bool) -> Void in
                    transitionContext.completeTransition(true)
            })
        case .dismissing:
            let fromController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
            let toController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
            transitionContext.containerView.addSubview(toController.view)

            fromController.view.alpha = 1
            UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: { () -> Void in
                fromController.view.alpha = 0
                }, completion: { (finished: Bool) -> Void in
                    transitionContext.completeTransition(true)
            })
        }
    }
    
}
