//
//  SlideTransitioningAnimator.swift
//  Spoken
//
//  Created by Adam Kirk on 5/7/15.
//  Copyright (c) 2015 Spoken. All rights reserved.
//

import UIKit


public class SlideTransitioningAnimator: BaseTransitioningAnimator, UIViewControllerAnimatedTransitioning {
    
    public enum Direction {
        case Left
        case Right
    }
    
    public var slideDirection: Direction?

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
            let fromEndRect: CGRect
            let toStartRect: CGRect
            let d = slideDirection ?? .Left
            switch d {
                case .Left:
                    fromEndRect = CGRectMake(fromStartRect.origin.x - fromStartRect.size.width, fromStartRect.origin.y, fromStartRect.size.width, fromStartRect.size.height)
                    toStartRect = CGRectMake(fromStartRect.origin.x + fromStartRect.size.width, fromStartRect.origin.y, fromStartRect.size.width, fromStartRect.size.height)
                case .Right:
                    fromEndRect = CGRectMake(fromStartRect.origin.x + fromStartRect.size.width, fromStartRect.origin.y, fromStartRect.size.width, fromStartRect.size.height)
                    toStartRect = CGRectMake(fromStartRect.origin.x - fromStartRect.size.width, fromStartRect.origin.y, fromStartRect.size.width, fromStartRect.size.height)
            }
            let toEndRect = fromStartRect

            fromController.view.frame = fromStartRect
            toController.view.frame = toStartRect
            UIView.animateWithDuration(self.transitionDuration(transitionContext), animations: { () -> Void in
                fromController.view.frame = fromEndRect
                toController.view.frame = toEndRect
            }, completion: { (finished: Bool) -> Void in
                transitionContext.completeTransition(true)
            })
        case .Dismissing:
            let fromController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
            let toController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
            transitionContext.containerView()!.addSubview(fromController.view)

            let fromStartRect = fromController.view.frame
            let fromEndRect: CGRect
            let toStartRect: CGRect
            let d = slideDirection ?? .Right
            switch d {
                case .Left:
                    fromEndRect = CGRectMake(fromStartRect.origin.x - fromStartRect.size.width, fromStartRect.origin.y, fromStartRect.size.width, fromStartRect.size.height)
                    toStartRect = CGRectMake(fromStartRect.origin.x + fromStartRect.size.width, fromStartRect.origin.y, fromStartRect.size.width, fromStartRect.size.height)
                case .Right:
                    fromEndRect = CGRectMake(fromStartRect.origin.x + fromStartRect.size.width, fromStartRect.origin.y, fromStartRect.size.width, fromStartRect.size.height)
                    toStartRect = CGRectMake(fromStartRect.origin.x - fromStartRect.size.width, fromStartRect.origin.y, fromStartRect.size.width, fromStartRect.size.height)
            }
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
    
    private func rectsForDirection(direction: Direction) {
        
    }

}
