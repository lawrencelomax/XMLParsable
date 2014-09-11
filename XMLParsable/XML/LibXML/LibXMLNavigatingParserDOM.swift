//
//  LibXMLNavigatingParserDOM.swift
//  XMLParsable
//
//  Created by Lawrence Lomax on 26/08/2014.
//  Copyright (c) 2014 Lawrence Lomax. All rights reserved.
//

import Foundation
import swiftz_core

public final class LibXMLNavigatingParserDOM: XMLNavigatingParserType, XMLParsableType {
  private let node: xmlNodePtr
  private let context: LibXMLDOM.Context?
  
  internal init (node: xmlNodePtr) {
    self.node = node
  }
  
  internal init (context: LibXMLDOM.Context) {
    self.context = context
    self.node = context.rootNode
  }
  
  deinit {
    self.context?.dispose()
  }
  
  public class func createWithData(data: NSData) -> Result<LibXMLNavigatingParserDOM> {
    return { LibXMLNavigatingParserDOM(context: $0) } <^> LibXMLDOM.createTreeWithData(data)
  }
  
  public class func createWithURL(url: NSURL) -> Result<LibXMLNavigatingParserDOM> {
    return { LibXMLNavigatingParserDOM(context: $0) } <^> LibXMLDOM.createTreeWithURL(url)
  }
  
  public func parseChildren(elementName: String) -> [LibXMLNavigatingParserDOM] {
    let foundChildren = filter(LibXMLDOM.childrenOfNode(self.node)) { node in
      LibXMLDOMGetElementType(node) == LibXMLElementType.ELEMENT_NODE && LibXMLDOMElementNameEquals(node, elementName)
    }
    return foundChildren.map { LibXMLNavigatingParserDOM(node: $0) }
  }
  
  public func parseText() -> String? {
    let foundChild = firstPassing(LibXMLDOM.childrenOfNode(self.node)) { node in
      return LibXMLDOMGetElementType(node) == LibXMLElementType.TEXT_NODE
    }
    return foundChild >>- LibXMLDOMGetText
  }  
}
