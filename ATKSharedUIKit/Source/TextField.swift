//
//  TextField.swift
//  Spoken
//
//  Created by Adam Kirk on 5/5/15.
//  Copyright (c) 2015 Spoken. All rights reserved.
//

import UIKit

@IBDesignable
class TextField: UITextField {

    @IBInspectable var inset: CGFloat = 0

    override func textRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectInset(bounds, inset, 0)
    }

    override func editingRectForBounds(bounds: CGRect) -> CGRect {
        return textRectForBounds(bounds)
    }

    override func placeholderRectForBounds(bounds: CGRect) -> CGRect {
        return textRectForBounds(bounds)
    }
    
}
