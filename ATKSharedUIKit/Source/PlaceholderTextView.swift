//
//  PlaceholderTextView.swift
//  TouchForms
//
//  Created by Adam Kirk on 10/12/15.
//  Copyright © 2015 Adam Kirk. All rights reserved.
//

import UIKit

@IBDesignable
open class PlaceholderTextView: UITextView {
    
    @IBInspectable
    open var placeholderText: String?
    
    open override func didMoveToWindow() {
        super.didMoveToWindow()
        NotificationCenter.default.addObserver(self, selector: #selector(PlaceholderTextView.textDidChangeNotification(_:)), name: NSNotification.Name.UITextViewTextDidChange, object: self)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override open func draw(_ rect: CGRect) {
        super.draw(rect)
        if let placeholder = placeholderText , text.isEmpty {
            (placeholder as NSString).draw(at: CGPoint(x: textContainerInset.left + textContainer.lineFragmentPadding, y: textContainerInset.top), withAttributes: [
                NSAttributedStringKey.font: self.font ?? UIFont.systemFont(ofSize: 12),
                NSAttributedStringKey.foregroundColor: UIColor(white: 0.8, alpha: 1)
                ])
        }
    }
    
    @objc func textDidChangeNotification(_ note: Notification) {
        setNeedsDisplay()
    }

}
