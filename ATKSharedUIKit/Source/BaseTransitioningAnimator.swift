//
//  BaseTransitioningAnimator.swift
//  Spoken
//
//  Created by Adam Kirk on 5/30/15.
//  Copyright (c) 2015 Spoken. All rights reserved.
//

import Foundation


enum BaseTransitioningAnimatorDirection {
    case Presenting
    case Dismissing
}

class BaseTransitioningAnimator: NSObject {

    var direction: BaseTransitioningAnimatorDirection

    required init(direction: BaseTransitioningAnimatorDirection = .Presenting) {
        self.direction = direction
    }

}