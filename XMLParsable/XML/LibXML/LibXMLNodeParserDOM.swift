//
//  LibXMLNodeParserDOM.swift
//  XMLParsable
//
//  Created by Lawrence Lomax on 21/08/2014.
//  Copyright (c) 2014 Lawrence Lomax. All rights reserved.
//

import Foundation
import swiftz_core

public class LibXMLNodeParserDOM: XMLNodeParserType {
  public class func createTreeWithData(data: NSData) -> Result<XMLNode> {
    return self.processContext(LibXMLDOM.createTreeWithData(data))
  }
  
  public class func createTreeWithURL(url: NSURL) -> Result<XMLNode> {
    return self.processContext(LibXMLDOM.createTreeWithURL(url))
  }
  
  private class func processContext(context: Result<LibXMLDOM.Context>) -> Result<XMLNode> {
    switch context {
    case .Value(let box):
      let result = self.createTreeRecursive(box.value.rootNode)
      box.value.dispose()
      return Result.value(result)
    case .Error(let error):
      return Result.Error(error)
    }
  }
  
  private class func createTreeRecursive(node: xmlNodePtr) -> XMLNode {
    let name: String! = LibXMLDOMGetName(node)
    var text: String?
    
    var children: [XMLNode] = []
    
    for child in LibXMLDOM.childrenOfNode(node) {
      switch LibXMLDOMGetElementType(child) {
      case .ELEMENT_NODE:
        children.append(LibXMLNodeParserDOM.createTreeRecursive(child))
      case .TEXT_NODE:
        text = LibXMLDOMGetText(child)
      default:
        break
      }
    }
    
    return XMLNode(name: name, text: text, children: children)
  }
}
