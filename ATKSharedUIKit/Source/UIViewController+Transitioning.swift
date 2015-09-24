//
//  UIViewController+Transitioning.swift
//  Spoken
//
//  Created by Adam Kirk on 5/25/15.
//  Copyright (c) 2015 Spoken. All rights reserved.
//

import UIKit

private var transitioningDelegateKey = "transitioningDelegateKey"

public extension UIViewController {

    public var retainedTransitioningDelegate: UIViewControllerTransitioningDelegate? {
        get {
            return objc_getAssociatedObject(self, &transitioningDelegateKey) as? UIViewControllerTransitioningDelegate
        }
        set(newValue) {
            objc_setAssociatedObject(self, &transitioningDelegateKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }

    public func customTransitionToController(controller: UIViewController, transitioningDelegate: UIViewControllerTransitioningDelegate) {
        self.retainedTransitioningDelegate = transitioningDelegate
        controller.transitioningDelegate = transitioningDelegate
        controller.modalPresentationStyle = .Custom
    }

}
