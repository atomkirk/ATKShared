//
//  LoadingCircleView.swift
//  Spoken
//
//  Created by Adam Kirk on 7/18/15.
//  Copyright (c) 2015 Spoken. All rights reserved.
//

import UIKit

@IBDesignable
class LoadingCircleView: UIView {

    private var rotating = true

    override func didMoveToWindow() {
        if self.window != nil {
            rotating = true
            rotate()
        }
        else {
            rotating = false
        }
    }

    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        UIColor(red: 0.984, green: 0, blue: 0.714, alpha: 1).setStroke()
        CGContextSetLineWidth(context, 1)
        let frame = CGRectInset(self.bounds, 1, 1)
        CGContextAddArc(context,
            CGRectGetMidX(frame),
            CGRectGetMidY(frame),
            CGRectGetWidth(frame) / CGFloat(2),
            CGFloat(M_2_PI),
            0,
            0);
        CGContextStrokePath(context)
    }

    private func rotate() {
        if rotating {
            self.transform = CGAffineTransformIdentity
            UIView.animateWithDuration(0.75, delay: 0, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
                self.transform = CGAffineTransformMakeRotation(CGFloat(M_PI ))
                }) { (finished) -> Void in
                    UIView.animateWithDuration(0.75, delay: 0, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
                        self.transform = CGAffineTransformMakeRotation(0)
                        }) { (finished) -> Void in
                            self.rotate()
                    }
            }
        }
    }

}