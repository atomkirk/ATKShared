//
//  PlaceholderTextView.swift
//  TouchForms
//
//  Created by Adam Kirk on 10/12/15.
//  Copyright © 2015 Adam Kirk. All rights reserved.
//

import UIKit

@IBDesignable
public class PlaceholderTextView: UITextView {
    
    @IBInspectable
    public var placeholderText: String?
    
    public override func didMoveToWindow() {
        super.didMoveToWindow()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "textDidChangeNotification:", name: UITextViewTextDidChangeNotification, object: self)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override public func drawRect(rect: CGRect) {
        super.drawRect(rect)
        if let placeholder = placeholderText where text.isEmpty {
            (placeholder as NSString).drawAtPoint(CGPoint(x: textContainerInset.left + textContainer.lineFragmentPadding, y: textContainerInset.top), withAttributes: [
                NSFontAttributeName: self.font ?? UIFont.systemFontOfSize(UIFont.systemFontSize()),
                NSForegroundColorAttributeName: UIColor(white: 0.8, alpha: 1)
                ])
        }
    }
    
    func textDidChangeNotification(note: NSNotification) {
        setNeedsDisplay()
    }

}
