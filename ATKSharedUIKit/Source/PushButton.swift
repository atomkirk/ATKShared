//
//  Button.swift
//  Concierge
//
//  Created by Adam Kirk on 8/18/15.
//  Copyright (c) 2015 Mysterious Trousers. All rights reserved.
//

import UIKit

open class PushButton: UIButton {
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        pushIn()
    }
    
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        popOut()
    }
    
    open override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        popOut()
    }
    
    fileprivate func pushIn() {
        UIView.animate(withDuration: 0.1, delay: 0, options: UIViewAnimationOptions.beginFromCurrentState, animations: { () -> Void in
            self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }) { (finished) -> Void in
            
        }
    }
    
    fileprivate func popOut() {
        UIView.animate(withDuration: 0.1, delay: 0, options: UIViewAnimationOptions.beginFromCurrentState, animations: { () -> Void in
            self.transform = CGAffineTransform.identity
        }) { (finished) -> Void in
                
        }
    }
    
}
