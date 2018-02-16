//
//  LoadingCircleView.swift
//  Spoken
//
//  Created by Adam Kirk on 7/18/15.
//  Copyright (c) 2015 Spoken. All rights reserved.
//

import UIKit

@IBDesignable
open class LoadingCircleView: UIView {

    fileprivate var rotating = true

    open override func didMoveToWindow() {
        if self.window != nil {
            rotating = true
            rotate()
        }
        else {
            rotating = false
        }
    }

    open override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        UIColor(red: 0.984, green: 0, blue: 0.714, alpha: 1).setStroke()
        context?.setLineWidth(1)
        let frame = self.bounds.insetBy(dx: 1, dy: 1)
        
        context?.addArc(center: CGPoint(x: frame.midX, y: frame.midY), radius: frame.width / CGFloat(2), startAngle: CGFloat(M_2_PI), endAngle: 0, clockwise: false)
//        CGContextAddArc(context,
//            frame.midX,
//            frame.midY,
//            frame.width / CGFloat(2),
//            CGFloat(M_2_PI),
//            0,
//            0);
        context?.strokePath()
    }

    fileprivate func rotate() {
        if rotating {
            self.transform = CGAffineTransform.identity
            UIView.animate(withDuration: 0.75, delay: 0, options: UIViewAnimationOptions.curveLinear, animations: { () -> Void in
                self.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi ))
                }) { (finished) -> Void in
                    UIView.animate(withDuration: 0.75, delay: 0, options: UIViewAnimationOptions.curveLinear, animations: { () -> Void in
                        self.transform = CGAffineTransform(rotationAngle: 0)
                        }) { (finished) -> Void in
                            self.rotate()
                    }
            }
        }
    }

}
