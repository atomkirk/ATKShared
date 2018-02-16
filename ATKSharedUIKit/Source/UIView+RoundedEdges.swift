//
//  RoundedEdgeView.swift
//  Concierge
//
//  Created by Adam Kirk on 8/17/15.
//  Copyright (c) 2015 Mysterious Trousers. All rights reserved.
//

import UIKit

public extension UIView {
    
    public func roundCorners(_ corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
}
