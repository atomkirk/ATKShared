//
//  Promise.swift
//  Spoken
//
//  Created by Adam Kirk on 6/25/15.
//  Copyright (c) 2015 Spoken. All rights reserved.
//

import Foundation

public class Promise<T> {

    public typealias PromiseSuccessBlock = (result: T) -> Void
    public typealias PromiseFailureBlock = (error: NSError?) -> Void
    public typealias PromiseAlwaysBlock  = () -> Void

    private(set) var successBlocks = [PromiseSuccessBlock]()
    private(set) var failureBlocks = [PromiseFailureBlock]()
    private(set) var alwaysBlocks  = [PromiseAlwaysBlock]()

    public func success(block: PromiseSuccessBlock) -> Self {
        successBlocks.append(block)
        return self
    }

    public func failure(block: PromiseFailureBlock) -> Self {
        failureBlocks.append(block)
        return self
    }

    public func always(block: PromiseAlwaysBlock) -> Self {
        alwaysBlocks.append(block)
        return self
    }

    public func resolve(result: T) {
        successBlocks.map { $0(result: result) }
        alwaysBlocks.map { $0() }
    }

    public func reject(error: NSError?) {
        failureBlocks.map { $0(error: error) }
        alwaysBlocks.map { $0() }
    }

}