//
//  Functions.swift
//  XMLParsable
//
//  Created by Lawrence Lomax on 11/17/14.
//  Copyright (c) 2014 Lawrence Lomax. All rights reserved.
//

import Foundation
import swiftz_core

infix operator >=> {
associativity left
}

public func >=><A, B, C>(f0: A -> Result<B>, f1: B -> Result<C>) -> A -> Result<C> {
  return { input in
    switch f0(input) {
    case .Value(let box): return f1(box.value)
    case .Error(let error): return Result.Error(error)
    }
  }
}
