//
//  ResultMatchers.swift
//  XMLParsable
//
//  Created by Lawrence Lomax on 19/08/2014.
//  Copyright (c) 2014 Lawrence Lomax. All rights reserved.
//

import Foundation
import Nimble
import swiftz_core
import XMLParsable

func beAValue<T>() -> MatcherFunc<Result<T>> {
  return MatcherFunc { actualThunk, failureMessage in
    let actual = actualThunk.evaluate()
    if actual == nil {
      failureMessage.postfixMessage = "be a value: got nothing"
      return false
    }
    switch actual! {
      case .Error(let error):
        failureMessage.postfixMessage = "be a value: got \(error)"
        return false
      default:
        return true
    }
  }
}

func beAnError<T>() -> MatcherFunc<Result<T>> {
  return MatcherFunc { actualThunk, failureMessage in
    let actual = actualThunk.evaluate()
    if actual == nil {
      failureMessage.postfixMessage = "be an error: got nothing"
      return false
    }
    switch actual! {
      case .Value(let box):
        failureMessage.postfixMessage = "be an error: get \(box.value)"
        return false
      default:
        return true
    }
  }
}
