//
//  UIScrollView+Edges.swift
//  ATKShared
//
//  Created by Adam Kirk on 10/15/15.
//  Copyright © 2015 Adam Kirk. All rights reserved.
//

import UIKit

public extension UIScrollView {
    
    public func isWithinPoints(points: CGFloat, toEdge edge: UIRectEdge) -> Bool {
        let offsetLength: CGFloat
        let viewLength: CGFloat
        let contentLength: CGFloat
        let distanceFromEdge: CGFloat
        
        switch edge {
            case UIRectEdge.Top:
                distanceFromEdge = fabs(contentOffsetY)
                offsetLength = 0
                viewLength = 0
                contentLength = 0
            
            case UIRectEdge.Right:
                offsetLength = fabs(contentOffsetX)
                viewLength = fabs(bounds.size.width)
                contentLength = fabs(contentSize.width)
                distanceFromEdge = contentLength - (offsetLength + viewLength)
            
            case UIRectEdge.Bottom:
                offsetLength = fabs(contentOffsetY)
                viewLength = fabs(bounds.size.height)
                contentLength = fabs(contentSize.height)
                distanceFromEdge = contentLength - (offsetLength + viewLength)
            
            default: // UIRectEdge.Left
                offsetLength = 0
                viewLength = 0
                contentLength = 0
                distanceFromEdge = contentOffsetX
        }
        
        
        return distanceFromEdge < points
    }
    
}