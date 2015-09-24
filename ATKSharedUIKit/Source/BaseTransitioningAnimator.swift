//
//  BaseTransitioningAnimator.swift
//  Spoken
//
//  Created by Adam Kirk on 5/30/15.
//  Copyright (c) 2015 Spoken. All rights reserved.
//

import Foundation


public enum BaseTransitioningAnimatorDirection {
    case Presenting
    case Dismissing
}

public class BaseTransitioningAnimator: NSObject {

    public var direction: BaseTransitioningAnimatorDirection

    public required init(direction: BaseTransitioningAnimatorDirection = .Presenting) {
        self.direction = direction
    }

}