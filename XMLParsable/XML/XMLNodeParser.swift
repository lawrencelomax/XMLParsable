//
//  XMLParser.swift
//  XMLParsable
//
//  Created by Lawrence Lomax on 14/08/2014.
//  Copyright (c) 2014 Lawrence Lomax. All rights reserved.
//

import Foundation
import swiftz_core

public struct XMLNode: XMLParsableType {
  public let name: String
  public let text: String?
  public let children: [XMLNode]
	
  public func parseChildren(elementName: String) -> [XMLNode] {
    return self.children.filter { node in
      return node.name == elementName
    }
  }
  
  public func parseText() -> String? {
    return self.text
  }
}

public class XMLNodeParser: XMLParsableFactoryType {
  public class func createWithData(data: NSData) -> Result<XMLNode> {
    return LibXMLNodeParserReader.createWithData(data)
  }
  
  public class func createWithURL(url: NSURL) -> Result<XMLNode> {
    return LibXMLNodeParserReader.createWithURL(url)
  }
  
  public class func recursiveDescription(node: XMLNode) {
    self.recursiveDescription(node, indentLevel: 0)
  }
  
  private class func recursiveDescription(node: XMLNode, indentLevel: Int) {
    let generateWhitespace: Void -> String = {
      var whitespace = ""
      for foo in 0...indentLevel {
        whitespace += " "
      }
      return whitespace
    }
    
    switch node.text {
    case .Some(let child): println("\(generateWhitespace()) \(node.name) \(node.text)")
    default: break
    }
    
    for child in node.children {
      self.recursiveDescription(child, indentLevel: indentLevel + 1)
    }
  }
}
