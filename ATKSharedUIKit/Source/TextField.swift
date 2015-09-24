//
//  TextField.swift
//  Spoken
//
//  Created by Adam Kirk on 5/5/15.
//  Copyright (c) 2015 Spoken. All rights reserved.
//

import UIKit

@IBDesignable
public class TextField: UITextField {

    @IBInspectable var inset: CGFloat = 0

    public override func textRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectInset(bounds, inset, 0)
    }

    public override func editingRectForBounds(bounds: CGRect) -> CGRect {
        return textRectForBounds(bounds)
    }

    public override func placeholderRectForBounds(bounds: CGRect) -> CGRect {
        return textRectForBounds(bounds)
    }
    
}
