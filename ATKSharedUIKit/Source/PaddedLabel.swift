//
//  PaddedLabel.swift
//  ATKShared
//
//  Created by Adam Kirk on 10/21/15.
//  Copyright © 2015 Adam Kirk. All rights reserved.
//

import UIKit

@IBDesignable
public class PaddedLabel: UILabel {
    
    @IBInspectable public var topEdgeInset: CGFloat = 0
    
    @IBInspectable public var leftEdgeInset: CGFloat = 0
    
    @IBInspectable public var bottomEdgeInset: CGFloat = 0
    
    @IBInspectable public var rightEdgeInset: CGFloat = 0
    
    public override func drawTextInRect(rect: CGRect) {
        let insets = UIEdgeInsets(top: topEdgeInset, left: leftEdgeInset, bottom: bottomEdgeInset, right: rightEdgeInset)
        return super.drawTextInRect(UIEdgeInsetsInsetRect(rect, insets))
    }
    
    public override func intrinsicContentSize() -> CGSize {
        var size = super.intrinsicContentSize()
        size.width += leftEdgeInset + rightEdgeInset
        size.height += topEdgeInset + bottomEdgeInset
        return size
    }
    
}
