//
//  PaddedLabel.swift
//  ATKShared
//
//  Created by Adam Kirk on 10/21/15.
//  Copyright © 2015 Adam Kirk. All rights reserved.
//

import UIKit

@IBDesignable
open class PaddedLabel: UILabel {
    
    @IBInspectable open var topEdgeInset: CGFloat = 0
    
    @IBInspectable open var leftEdgeInset: CGFloat = 0
    
    @IBInspectable open var bottomEdgeInset: CGFloat = 0
    
    @IBInspectable open var rightEdgeInset: CGFloat = 0
    
    open override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topEdgeInset, left: leftEdgeInset, bottom: bottomEdgeInset, right: rightEdgeInset)
        return super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
    }
    
    open override var intrinsicContentSize : CGSize {
        var size = super.intrinsicContentSize
        size.width += leftEdgeInset + rightEdgeInset
        size.height += topEdgeInset + bottomEdgeInset
        return size
    }
    
}
