//
//  SequenceExtension.swift
//  XMLParsable
//
//  Created by Lawrence Lomax on 11/09/2014.
//  Copyright (c) 2014 Lawrence Lomax. All rights reserved.
//

import Foundation

public func firstPassing<S: SequenceType>(domain: S, predicate: S.Generator.Element -> Bool) -> S.Generator.Element? {
  return first(filter(domain, predicate))
}
