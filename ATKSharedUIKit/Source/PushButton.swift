//
//  Button.swift
//  Concierge
//
//  Created by Adam Kirk on 8/18/15.
//  Copyright (c) 2015 Mysterious Trousers. All rights reserved.
//

import UIKit

public class PushButton: UIButton {
    
    public override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        pushIn()
    }
    
    public override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesEnded(touches, withEvent: event)
        popOut()
    }
    
    public override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        super.touchesCancelled(touches, withEvent: event)
        popOut()
    }
    
    private func pushIn() {
        UIView.animateWithDuration(0.1, delay: 0, options: UIViewAnimationOptions.BeginFromCurrentState, animations: { () -> Void in
            self.transform = CGAffineTransformMakeScale(0.9, 0.9)
        }) { (finished) -> Void in
            
        }
    }
    
    private func popOut() {
        UIView.animateWithDuration(0.1, delay: 0, options: UIViewAnimationOptions.BeginFromCurrentState, animations: { () -> Void in
            self.transform = CGAffineTransformIdentity
        }) { (finished) -> Void in
                
        }
    }
    
}
