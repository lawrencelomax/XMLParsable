//
//  ResultExtensions.swift
//  XMLParsable
//
//  Created by Lawrence Lomax on 12/08/2014.
//  Copyright (c) 2014 Lawrence Lomax. All rights reserved.
//

import Foundation
import swiftz_core

public let ResultExtensionErrorDomain = InMyDomain("result.generic")
public let NoValueError = NSError(domain: ResultExtensionErrorDomain, code: 0, userInfo: [NSLocalizedDescriptionKey: "No Value Provided"])

public extension Result {
  public static func construct(maybeValue: V?)(maybeError: NSError?) -> Result<V> {
    switch maybeValue {
    case .Some(let value): return Result.value(value)
    default: break
    }
    switch maybeError {
    case .Some(let error): return Result.Error(error)
    default: break
    }
    return Result.Error(NoValueError)
  }
  
  public static func promote(error: NSError)(value: V?) -> Result<V> {
    switch value {
    case .Some(let value): return Result.value(value)
    case .None: return Result.error(error)
    }
  }
  
  public func isError() -> Bool {
    switch self {
    case .Value: return false
    case .Error: return true
    }
  }
  
  public func isValue() -> Bool {
    switch self {
    case .Value: return true
    case .Error: return false
    }
  }
  
  public func toOptional() -> V? {
    return resultToOptional(self)
  }
}

public func resultToOptional<V>(result: Result<V>) -> V? {
  switch result {
  case .Value(let box): return .Some(box.value)
  case .Error(let _): return .None
  }
}


