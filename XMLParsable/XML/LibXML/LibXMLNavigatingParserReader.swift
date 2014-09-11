//
//  LibXMLNavigatingParserReader.swift
//  XMLParsable
//
//  Created by Lawrence Lomax on 26/08/2014.
//  Copyright (c) 2014 Lawrence Lomax. All rights reserved.
//

import Foundation
import swiftz_core

public final class LibXMLNavigatingParserReader: XMLNavigatingParserType, XMLParsableType {
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
  
  public class func createWithData(data: NSData) -> Result<XMLParsableType> {
    return { LibXMLNavigatingParserReader(context: $0, isRoot: true) } <^> LibXMLReader.createReader(data)
  }
  
  public class func createWithURL(url: NSURL) -> Result<XMLParsableType> {
    return { LibXMLNavigatingParserReader(context: $0, isRoot: true) } <^> LibXMLReader.createReader(url)
  }
  
  public func parseText() -> String? {
    
  }
}
