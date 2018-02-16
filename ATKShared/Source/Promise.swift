//
//  Promise.swift
//  Spoken
//
//  Created by Adam Kirk on 6/25/15.
//  Copyright (c) 2015 Spoken. All rights reserved.
//

import Foundation

open class Promise<T> {

    public typealias PromiseSuccessBlock = (_ result: T) -> Void
    public typealias PromiseFailureBlock = (_ error: NSError?) -> Void
    public typealias PromiseAlwaysBlock  = () -> Void

    fileprivate(set) var successBlocks = [PromiseSuccessBlock]()
    fileprivate(set) var failureBlocks = [PromiseFailureBlock]()
    fileprivate(set) var alwaysBlocks  = [PromiseAlwaysBlock]()
    
    public init() {}

    open func success(_ block: @escaping PromiseSuccessBlock) -> Self {
        successBlocks.append(block)
        return self
    }

    open func failure(_ block: @escaping PromiseFailureBlock) -> Self {
        failureBlocks.append(block)
        return self
    }

    open func always(_ block: @escaping PromiseAlwaysBlock) -> Self {
        alwaysBlocks.append(block)
        return self
    }

    open func resolve(_ result: T) {
        successBlocks.forEach { $0(result) }
        alwaysBlocks.forEach { $0() }
    }

    open func reject(_ error: NSError?) {
        failureBlocks.forEach { $0(error) }
        alwaysBlocks.forEach { $0() }
    }

}
