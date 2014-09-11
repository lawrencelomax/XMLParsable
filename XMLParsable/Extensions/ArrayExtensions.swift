//
//  ArrayExtensions.swift
//  XMLParsable
//
//  Created by Lawrence Lomax on 11/08/2014.
//  Copyright (c) 2014 Lawrence Lomax. All rights reserved.
//

import Foundation
import swiftz_core

public func maybeMapC<A, B>(map: A -> B?)(array: [A]) -> [B]? {
  return maybeMap(array, map)
}

public func maybeMap<A, B>(array: [A], map: A -> B?) -> [B]? {
  var output: [B] = []
  
  for item in array {
    switch map(item) {
    case .Some(let mappedValue): output.append(mappedValue)
    case .None: return .None
    }
  }
  
  return output
}

public func resultMapC<A, B>(map: A -> Result<B>)(array: [A]) -> Result<[B]> {
  return resultMap(array, map)
}

public func resultMap<A, B>(array: [A], map: A -> Result<B>) -> Result<[B]> {
  var mapped: [B] = []
  
  for item in array {
    switch map(item) {
    case .Error(let error): return Result.Error(error)
    case .Value(let box): mapped.append(box.value)
    }
  }
  
  return Result.value(mapped)
}
