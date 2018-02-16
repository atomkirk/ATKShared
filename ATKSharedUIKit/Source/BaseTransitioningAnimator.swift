//
//  BaseTransitioningAnimator.swift
//  Spoken
//
//  Created by Adam Kirk on 5/30/15.
//  Copyright (c) 2015 Spoken. All rights reserved.
//

import Foundation


public enum BaseTransitioningAnimatorDirection {
    case presenting
    case dismissing
}

open class BaseTransitioningAnimator: NSObject {

    open var direction: BaseTransitioningAnimatorDirection

    public required init(direction: BaseTransitioningAnimatorDirection = .presenting) {
        self.direction = direction
    }

}
