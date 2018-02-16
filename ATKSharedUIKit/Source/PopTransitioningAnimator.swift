//
//  PopTransitioningAnimator.swift
//  Spoken
//
//  Created by Adam Kirk on 5/29/15.
//  Copyright (c) 2015 Spoken. All rights reserved.
//

import UIKit

open class PopTransitioningAnimator: BaseTransitioningAnimator, UIViewControllerAnimatedTransitioning {

    open func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        if self.direction == .presenting {
            return 1
        }
        else {
            return 0.33
        }
    }

    open func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        switch self.direction {
        case .presenting:
            let fromController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
            let toController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
            transitionContext.containerView.addSubview(toController.view)

            toController.view.alpha = 0
            toController.view.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            fromController.view.transform = CGAffineTransform.identity
            UIView.animate(withDuration: self.transitionDuration(using: transitionContext), delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 10, options: [], animations: { () -> Void in
                toController.view.alpha = 1
                toController.view.transform = CGAffineTransform.identity
                fromController.view.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                }, completion: { (finished: Bool) -> Void in
                    transitionContext.completeTransition(true)
            })
        case .dismissing:
            let fromController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
            let toController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
            transitionContext.containerView.addSubview(fromController.view)

            fromController.view.alpha = 1
            fromController.view.transform = CGAffineTransform.identity
            toController.view.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: { () -> Void in
                fromController.view.alpha = 0
                fromController.view.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                toController.view.transform = CGAffineTransform.identity
                }, completion: { (finished: Bool) -> Void in
                    transitionContext.completeTransition(true)
            })
        }
    }
    
}
