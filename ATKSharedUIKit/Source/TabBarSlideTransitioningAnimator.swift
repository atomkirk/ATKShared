//
//  TabBarSlideTransitioningAnimator.swift
//  Spoken
//
//  Created by Adam Kirk on 5/15/15.
//  Copyright (c) 2015 Spoken. All rights reserved.
//

import UIKit

open class TabBarSlideTransitioningAnimator: BaseTransitioningAnimator, UIViewControllerAnimatedTransitioning {

    fileprivate let offset = CGFloat(10)

    open func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.33
    }

    open func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        switch self.direction {
        case .presenting:
            let fromController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
            let toController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as! UITabBarController
            transitionContext.containerView.addSubview(toController.view)

            var tabBarStartRect = toController.tabBar.frame
            let tabBarEndRect = tabBarStartRect
            tabBarStartRect.origin.y += tabBarStartRect.height

            let fromStartRect = fromController.view.frame
            var fromEndRect = fromStartRect
            fromEndRect.origin.x -= fromStartRect.width

            var toStartRect = fromStartRect
            let toEndRect = fromStartRect
            toStartRect.origin.x += toStartRect.width

            toController.tabBar.frame = tabBarStartRect
            fromController.view.frame = fromStartRect
            toController.selectedViewController!.view.frame = toStartRect
            UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: { () -> Void in
                toController.tabBar.frame = tabBarEndRect
                fromController.view.frame = fromEndRect
                toController.selectedViewController!.view.frame = toEndRect
            }, completion: { (finished: Bool) -> Void in
                transitionContext.completeTransition(true)
            })
        case .dismissing:
//            let fromController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! UITabBarController
//            let toController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
//            transitionContext.containerView().addSubview(fromController.view)
//
//            var tabBarStartRect = fromController.tabBar.frame
//            var tabBarEndRect = tabBarStartRect
//            tabBarEndRect.origin.y += CGRectGetHeight(tabBarStartRect)
//
//            var controllerStartRect = fromController.view.frame
//            var controllerEndRect = controllerStartRect
//            controllerEndRect.origin.y += CGRectGetHeight(controllerStartRect)
//
//            fromController.navigationBar.frame = navBarStartRect
//            fromController.visibleViewController.view.frame = controllerStartRect
//            UIView.animateWithDuration(self.transitionDuration(transitionContext), animations: { () -> Void in
//                fromController.navigationBar.frame = navBarEndRect
//                fromController.visibleViewController.view.frame = controllerEndRect
//            }, completion: { (finished: Bool) -> Void in
//                transitionContext.completeTransition(true)
//            })
            transitionContext.completeTransition(true)
        }
    }
    
}
