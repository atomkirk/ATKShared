//
//  InsetTextField.swift
//  Spoken
//
//  Created by Adam Kirk on 5/5/15.
//  Copyright (c) 2015 Spoken. All rights reserved.
//

import UIKit

@IBDesignable
open class InsetTextField: UITextField {

    @IBInspectable var inset: CGFloat = 0

    open override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: inset, dy: 0)
    }

    open override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }

    open override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
    
}
