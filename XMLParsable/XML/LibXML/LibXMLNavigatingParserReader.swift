//
//  LibXMLNavigatingParserReader.swift
//  XMLParsable
//
//  Created by Lawrence Lomax on 26/08/2014.
//  Copyright (c) 2014 Lawrence Lomax. All rights reserved.
//

import Foundation
import swiftz_core

public final class LibXMLNavigatingParserReader: XMLParsableType, XMLParsableFactoryType {
  private class Container {
    let backingData: Either<NSData, NSURL>
    
    init (data: NSData) {
      self.backingData = Either.left(data)
    }
    
    init (url: NSURL) {
      self.backingData = Either.right(url)
    }
    
    func createContext() -> Result<LibXMLReader.Context> {
      switch backingData {
      case .Left(let box): return LibXMLReader.createReader(box.value)
      case .Right(let box): return LibXMLReader.createReader(box.value)
      }
    }
  }
  
  private class RootWrapper {
    
  }
  
  let context: LibXMLReader.Context
  let isRoot: Bool
  
  init (context: LibXMLReader.Context, isRoot: Bool = false) {
    self.context = context
    self.isRoot = isRoot
  }
  
  deinit {
    if (self.isRoot) {
      context.dispose()
    }
  }
  
  public class func createWithData(data: NSData) -> Result<LibXMLNavigatingParserReader> {
    return { LibXMLNavigatingParserReader(context: $0, isRoot: true) } <^> LibXMLReader.createReader(data)
  }
  
  public class func createWithURL(url: NSURL) -> Result<LibXMLNavigatingParserReader> {
    return { LibXMLNavigatingParserReader(context: $0, isRoot: true) } <^> LibXMLReader.createReader(url)
  }

  public func parseChildren(elementName: String) -> [LibXMLNavigatingParserReader] {
    
  }
  
  public func parseText() -> String? {
    
  }
}
